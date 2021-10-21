// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxSwift

class AppointmentRepository {
    
    let appointmentService: AppointmentService
    let dataStore: AppointmentsDataStore
    let facilityDataStore: FacilityDataStore
    let reachabilityService: ReachabilityService
    var isSyncing: Bool
    
    init(appointmentService: AppointmentService, dataStore: AppointmentsDataStore, facilityDataStore: FacilityDataStore) {
        self.appointmentService = appointmentService
        self.dataStore = dataStore
        self.facilityDataStore = facilityDataStore
        self.reachabilityService = ReachabilityService()
        self.isSyncing = false
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
                observer.onNext(self.dataStore.fetchAppointments(startDate: Date.startOfDay(date: date)))
                let appointments = self.dataStore.fetchAppointmentsSyncedFalse()
                if appointments.count >= 1 {
                    
                    //Mark:- Sync Appointments from server
                    if self.isSyncing == false {
                        self.syncData() {
                            (result: Result<Void,Error>) in
                            self.isSyncing = false
                            switch result {
                            case .failure (let error) :
                                print(error.localizedDescription)
                            case .success (_):
                                print("success")
                                self.fetchAppointmentsFromServer(date: date, observer: observer, facilityID: facilityID, residentId: nil)
                            }
                        }
                    }else{
                        
                        observer.onNext(self.dataStore.fetchAppointments(startDate: Date.startOfDay(date: date)))
                    }
                }else {
                    self.fetchAppointmentsFromServer(date: date, observer: observer, facilityID: facilityID, residentId: nil)
                }
                
            //Mark:- Internet Disconnected
            case .disconnected:
                
                observer.onNext(self.dataStore.fetchAppointments(startDate: Date.startOfDay(date: date)))
            }
            
            return Disposables.create()
        }
    }
    
    //Mark:- Fetch Appointments with facilityID, residentId and date
    func getAppointmentsForResident(for facilityID: Int,
                                    residentID: Int?,
                                    date: Date) -> Observable<[Appointment]> {
        
        return Observable.create { [weak self] observer in
            
            guard let self = self else { return Disposables.create() }
            
            //Mark:- Checking Internet Connection
            let reachability = self.reachabilityService.reachabilityType
            switch reachability {
            
            //Mark:- Internet Connected
            case .connected:
                observer.onNext(self.dataStore.fetchAppointmentsForResident(residentID: residentID!, startDate: Date.startOfDay(date: date)))
                let appointments = self.dataStore.fetchAppointmentsSyncedFalse()
                if appointments.count >= 1 {
                    
                    //Mark:- Sync Appointments from server
                    if self.isSyncing == false {
                        self.syncData() {
                            (result: Result<Void,Error>) in
                            self.isSyncing = false
                            switch result {
                            case .failure (let error) :
                                print(error.localizedDescription)
                            case .success (_):
                                print("success")
                                self.fetchAppointmentsFromServer(date: date, observer: observer, facilityID: facilityID, residentId: residentID)
                            }
                        }
                    }else{
                        
                        observer.onNext(self.dataStore.fetchAppointmentsForResident(residentID: residentID!, startDate: Date.startOfDay(date: date)))
                    }
                }else {
                    self.fetchAppointmentsFromServer(date: date, observer: observer, facilityID: facilityID, residentId: residentID)
                }
                
            //Mark:- Internet Disconnected
            case .disconnected:
                
                observer.onNext(self.dataStore.fetchAppointmentsForResident(residentID: residentID!, startDate: Date.startOfDay(date: date)))
                
            }
            
            return Disposables.create()
        }
    }
    
    //Mark:- Fetch Appointments from server
    func fetchAppointmentsFromServer(date : Date, observer : AnyObserver<[Appointment]>, facilityID: Int, residentId: Int?) {
        
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
                let updatedTime: Date = Date()
                for appointment in appointments {
                    self.dataStore.saveAppointment(appointment,updatedTime)
                }
                
                //Mark:- Returning appointments for that day
                if residentId != nil {
                    observer.onNext(self.dataStore.fetchAppointmentsForResident(residentID: residentId!, startDate: Date.startOfDay(date: date)))
                } else {
                    observer.onNext(self.dataStore.fetchAppointments(startDate: Date.startOfDay(date: date)))
                }
                observer.onCompleted()
            }
        }
        
    }
    
    
    //Mark:- Marking appointments in dataStore
    func updateAppointment(_ appointment: Appointment) {
        
        self.dataStore.updateAppointment(appointment)
        
    }
    
    //Mark:- Syncing appointments on Server
    func markAppointmentsOnServer(_ appointments: [Appointment],completion: @escaping (Result<AppointmentsResponse,Error>) -> Void) {
        
        //Mark:- Appointments Service syncing appointments
        self.appointmentService.syncAppointments(for: self.facilityDataStore.currentFacility?["facility_id"] as? Int ?? 0, params: appointments,completion: completion )
        
    }
    
    //Mark:- Setting Syncing Status
    func setIsSyncing(isSyncing: Bool) {
        self.isSyncing = isSyncing
    }
    
    //Mark:- Getting Syncing Status
    func getIsSyncing() -> Bool {
        return self.isSyncing
    }
    
    //Mark:- Syncing appointments on dataStore
    func syncData(completion: @escaping (Result<Void,Error>) -> Void) {
        
        //Mark:- Setting isSyncing True
        self.isSyncing = true
        
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
    
}
