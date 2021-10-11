// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxSwift

class AppointmentRepository {
    
    let appointmentService: AppointmentService
    let dataStore: AppointmentsDataStore
    let facilityDataStore: FacilityDataStore
    let reachabilityService: ReachabilityService
    
    init(appointmentService: AppointmentService, dataStore: AppointmentsDataStore, facilityDataStore: FacilityDataStore) {
        self.appointmentService = appointmentService
        self.dataStore = dataStore
        self.facilityDataStore = facilityDataStore
        self.reachabilityService = ReachabilityService()
    }
    
    //Mark:- Fetch Appointments with facilityID and date
    func getAppointments(for facilityID: Int,
                         date: Date) -> Observable<[Appointment]> {
        
        return Observable.create { [weak self] observer in
            
            guard let self = self else { return Disposables.create() }
            
            //Mark:- Checking Internet Connection
            let reachability = self.reachabilityService.reachabilityType
            switch reachability {
            
            //Mark:- Internet Connected
            case .connected:
                observer.onNext(self.dataStore.fetchAppointments(startDate: Double(Date.startOfDay(date: date).timeIntervalSince1970), endDate: Double(Date.endOfDay(date: date).timeIntervalSince1970)))
                let appointments = self.dataStore.fetchAppointmentsSyncedFalse()
                if appointments.count >= 1 {
                    
                    //Mark:- Sync Appointments from server
                    self.syncData() {
                        (result: Result<Void,Error>) in
                        switch result {
                        case .failure (let error) :
                            print(error.localizedDescription)
                        case .success (_):
                            print("success")
                            self.fetchAppointmentsFromServer(date: date, observer: observer, facilityID: facilityID)
                        }
                    }
                }else {
                    self.fetchAppointmentsFromServer(date: date, observer: observer, facilityID: facilityID)
                }
                
            //Mark:- Internet Disconnected
            case .disconnected:
                observer.onNext(self.dataStore.fetchAppointments(startDate: Double(Date.startOfDay(date: date).timeIntervalSince1970), endDate: Double(Date.endOfDay(date: date).timeIntervalSince1970)))
            }
            
            return Disposables.create()
        }
    }
    
    //Mark:- Fetch Appointments from server
    func fetchAppointmentsFromServer(date : Date, observer : AnyObserver<[Appointment]>, facilityID: Int) {
        
        //Mark:- Appointments Service fetching appointments
        self.appointmentService.getAppointments(for: facilityID,
                                                startDate: Date.startOfMonth(date: date).timeIntervalSince1970,
                                                endDate: Date.endOfMonth(date: date).timeIntervalSince1970) { (result: Result<[Appointment], Error>) in
            
            switch result {
            case .failure(let error):
                observer.onError(error)
            case .success(let appointments):
                
                //Mark:- Checking if appointments of that month exist
                let exist = self.checkAppointmentsExist(with: Date.startOfMonth(date: date), with: Date.endOfMonth(date: date))
                
                //Mark:- Deleting appointments for that month
                if exist {
                    self.deleteAppointments(with: Date.startOfMonth(date: date), with: Date.endOfMonth(date: date))
                }
                
                //Mark:- Saving appointments for that month
                for appointment in appointments {
                    self.dataStore.saveAppointment(appointment)
                }
                
                //Mark:- Returning appointments for that month
                observer.onNext(self.dataStore.fetchAppointments(startDate: Double(Date.startOfDay(date: date).timeIntervalSince1970), endDate: Double(Date.endOfDay(date: date).timeIntervalSince1970)))
                observer.onCompleted()
            }
        }
        
    }
    
    
    //Mark:- Marking appointments in dataStore
    func updateAppointment(_ appointment: Appointment) {
        self.dataStore.updateAppointment(appointment)
        
        //Mark:- Syncing appointments after marking in dataStore
        self.syncData() {
            (result: Result<Void,Error> ) in
            switch result {
            case .success():
                print("Updated Successfully")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //Mark:- Syncing appointments on Server
    func markAppointmentsOnServer(_ appointments: [Appointment],completion: @escaping (Result<AppointmentsResponse,Error>) -> Void) {
        
        //Mark:- Appointments Service syncing appointments
        self.appointmentService.syncAppointments(for: self.facilityDataStore.currentFacility?["id"] as? Int ?? 0, params: appointments,completion: completion )
        
    }
    
    
    //Mark:- Syncing appointments on dataStore
    func syncData(completion: @escaping (Result<Void,Error>) -> Void) {
        
        //Mark:- Fetch Appointments from dataStore which are not synced
        let appointments = self.dataStore.fetchAppointmentsSyncedFalse()
        
        //Mark:- Syncing appointments on server
        self.markAppointmentsOnServer(appointments) {
            (result: Result<AppointmentsResponse, Error>) in
            switch result {
            
            //Mark:- Checking Syncing appointments success
            case .success(let appointmentsResponse):
                
                //Mark:- Marking appointments synced true in dataStore
                if appointmentsResponse.success == true {
                    for appointment in appointments {
                        self.dataStore.markAppointmentsSyncedTrue(appointment)
                    }
                    
                }else {
                    
                    //Mark:- Marking only those appointments which are synced true from server in dataStore
                    let appointmentsSuccess : [Appointment] = appointments.filter { appointment in
                        return !(appointmentsResponse.failures?.contains(where: { appointmentFailure in
                            return appointmentFailure.id == appointment.id && appointmentFailure.occurrenceId == appointment.occurrenceId
                        }) ?? false)
                    }
                    
                    for appointment in appointmentsSuccess {
                        self.dataStore.markAppointmentsSyncedTrue(appointment)
                    }
                    
                }
                completion(Result.success(Void()))
                
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    //Mark:- Checking appointments of that month exist in dataStore
    func checkAppointmentsExist(with startDate: Date, with endDate: Date) -> Bool {
        return self.dataStore.checkAppointmentsExist(tartDate: Double(startDate.timeIntervalSince1970), endDate: Double(endDate.timeIntervalSince1970))
    }
    
    //Mark:- Deleting appointments of that month from dataStore
    func deleteAppointments(with startDate: Date, with endDate: Date) {
        do {
            try self.dataStore.deleteAppointments(startDate: Double(startDate.timeIntervalSince1970), endDate: Double(endDate.timeIntervalSince1970))
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    //Mark:- Deleting all appointments from dataStore
    func clearAllData(){
        do {
            try self.dataStore.deleteAllAppointment()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func whereIsMySQLite() {
        let path = FileManager
            .default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .last?
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
            .removingPercentEncoding
        
        print(path ?? "Not found")
    }
    
}
