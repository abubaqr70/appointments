// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxSwift

class AppointmentRepository {
    
    let appointmentService: AppointmentService
    let coreDataStore: AppointmentsDataStore
    let facilityDataStore: FacilityDataStore
    let reachabilityService: ReachabilityService
    
    init(appointmentService: AppointmentService, coreDataStore: AppointmentsDataStore, facilityDataStore: FacilityDataStore) {
        self.appointmentService = appointmentService
        self.coreDataStore = coreDataStore
        self.facilityDataStore = facilityDataStore
        self.reachabilityService = ReachabilityService()
    }
    
    func getAppointments(for facilityID: Int,
                         date: Date) -> Observable<[Appointment]> {
        
        return Observable.create { [weak self] observer in
            
            guard let self = self else { return Disposables.create() }
            let reachability = self.reachabilityService.currentReachabilityType()
            switch reachability {
            case .connected:
                observer.onNext(self.coreDataStore.fetchAppointments(with: Double(Date.startOfDay(with: date).timeIntervalSince1970), with: Double(Date.endOfDay(with: date).timeIntervalSince1970)))
                let appointments = self.coreDataStore.fetchAppointmentsSyncedFalse()
                if appointments.count >= 1 {
                    self.syncData() {
                        (result: Result<Void,Error>) in
                        switch result {
                        case .failure (let error) :
                            print(error.localizedDescription)
                        case .success (_):
                            print("success")
                            self.appointmentService.getAppointments(for: facilityID,
                                                                    startDate: Date.startOfDay(with: date).timeIntervalSince1970,
                                                                    endDate: Date.endOfDay(with: date).timeIntervalSince1970) { (result: Result<[Appointment], Error>) in
                                
                                switch result {
                                case .failure(let error):
                                    observer.onError(error)
                                case .success(let appointments):
                                    let exist = self.checkAppointmentsExist(with: Date.startOfMonth(with: date), with: Date.endOfMonth(with: date))
                                    if exist {
                                        self.deleteAppointments(with: Date.startOfMonth(with: date), with: Date.endOfMonth(with: date))
                                    }
                                    print(exist)
                                    for appointment in appointments {
                                        self.coreDataStore.saveAppointment(appointment)
                                    }
                                    observer.onNext(self.coreDataStore.fetchAppointments(with: Double(Date.startOfDay(with: date).timeIntervalSince1970), with: Double(Date.endOfDay(with: date).timeIntervalSince1970)))
                                    observer.onCompleted()
                                }
                            }
                        }
                    }
                }else {
                    self.appointmentService.getAppointments(for: facilityID,
                                                            startDate: Date.startOfDay(with: date).timeIntervalSince1970,
                                                            endDate: Date.endOfDay(with: date).timeIntervalSince1970) { (result: Result<[Appointment], Error>) in
                        
                        switch result {
                        case .failure(let error):
                            observer.onError(error)
                        case .success(let appointments):
                            
                            let exist = self.checkAppointmentsExist(with: Date.startOfMonth(with: date), with: Date.endOfMonth(with: date))
                            print(exist)
                            if exist {
                                self.deleteAppointments(with: Date.startOfMonth(with: date), with: Date.endOfMonth(with: date))
                            }
                            for appointment in appointments {
                                self.coreDataStore.saveAppointment(appointment)
                            }
                            observer.onNext(self.coreDataStore.fetchAppointments(with: Double(Date.startOfDay(with: date).timeIntervalSince1970), with: Double(Date.endOfDay(with: date).timeIntervalSince1970)))
                            observer.onCompleted()
                        }
                    }
                }
                
                
            case .disconnected:
                observer.onNext(self.coreDataStore.fetchAppointments(with: Double(Date.startOfDay(with: date).timeIntervalSince1970), with: Double(Date.endOfDay(with: date).timeIntervalSince1970)))
            }
            
            return Disposables.create()
        }
    }
    
    func markAppointments(_ appointments: [Appointment],completion: @escaping (Result<AppointmentsResponse,Error>) -> Void) {
        
        self.appointmentService.syncAppointments(for: self.facilityDataStore.currentFacility?["id"] as? Int ?? 0, params: appointments,completion: completion )
        
    }
    
    func getAppointment(_ appointment: Appointment) -> Appointment? {
        return self.coreDataStore.getAppointment(appointment)
    }
    
    func updateAppointment(_ appointment: Appointment) {
        self.coreDataStore.updateAppointment(appointment)
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
    
    func checkAppointmentsExist(with startDate: Date, with endDate: Date) -> Bool {
        return self.coreDataStore.checkAppointmentsExist(with: Double(startDate.timeIntervalSince1970), with: Double(endDate.timeIntervalSince1970))
    }
    
    func deleteAppointments(with startDate: Date, with endDate: Date) {
        do {
            try self.coreDataStore.deleteAppointments(with: Double(startDate.timeIntervalSince1970), with: Double(endDate.timeIntervalSince1970))
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func clearAllData(){
        do {
            try self.coreDataStore.deleteAllAppointment()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func syncData(completion: @escaping (Result<Void,Error>) -> Void) {
        let appointments = self.coreDataStore.fetchAppointmentsSyncedFalse()
        
        self.markAppointments(appointments) {
            (result: Result<AppointmentsResponse, Error>) in
            switch result {
            case .success(let appointmentsResponse):
                
                if appointmentsResponse.success == true {
                    for appointment in appointments {
                        self.coreDataStore.markAppointmentsSyncedTrue(appointment)
                    }
                }else {
                    let appointmentsSuccess : [Appointment] = appointments.filter { appointment in
                        return !(appointmentsResponse.failures?.contains(where: { appointmentFailure in
                            return appointmentFailure.id == appointment.id && appointmentFailure.occurrenceId == appointment.occurrenceId
                        }) ?? false)
                    }
                    for appointment in appointmentsSuccess {
                        self.coreDataStore.markAppointmentsSyncedTrue(appointment)
                    }
                }
                completion(Result.success(Void()))
                
            case .failure(let error):
                completion(Result.failure(error))
            }
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
