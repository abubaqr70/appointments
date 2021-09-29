// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxSwift

class AppointmentRepository {
    
    let appointmentService: AppointmentService
    let coreDataStore: AppointmentsCoreDataStore
    
    init(appointmentService: AppointmentService, coreDataStore: AppointmentsCoreDataStore) {
        self.appointmentService = appointmentService
        self.coreDataStore = coreDataStore
    }
    
    func getAppointments(for facilityID: Int,
                        startDate: TimeInterval,
                        endDate: TimeInterval) -> Observable<[Appointment]> {
        
        return Observable.create { [weak self] observer in
            
            guard let self = self else { return Disposables.create() }
            
            self.appointmentService.getAppointments(for: facilityID,
                                                    startDate: startDate,
                                                    endDate: endDate) { (result: Result<[Appointment], Error>) in
                
                switch result {
                case .failure(let error):
                    observer.onError(error)
                case .success(let appointments):
//                    self.whereIsMySQLite()
//                    try? self.coreDataStore.deleteALLCDAppointment()
//                    for appointment in appointments{
//                        self.coreDataStore.saveAppointment(appointment)
//                    }
//                    let newAppointments = self.coreDataStore.fetchAppointments()
//                    print("Core Data Appointments \(newAppointments)")
                    observer.onNext(appointments)
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }
    }
}

extension AppointmentRepository{
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
