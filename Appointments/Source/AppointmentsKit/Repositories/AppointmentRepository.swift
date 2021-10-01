// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxSwift

class AppointmentRepository {
    
    let appointmentService: AppointmentService
    let coreDataStore: AppointmentsCoreDataStore
    let facilityDataStore: FacilityDataStore
    
    init(appointmentService: AppointmentService, coreDataStore: AppointmentsCoreDataStore, facilityDataStore: FacilityDataStore) {
        self.appointmentService = appointmentService
        self.coreDataStore = coreDataStore
        self.facilityDataStore = facilityDataStore
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
                    self.clearData()
                    for appointment in appointments {
                        self.coreDataStore.saveAppointment(appointment)
                    }
                    observer.onNext(self.coreDataStore.fetchAppointments())
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }
    }
    
    func clearData(){
        do {
            try self.coreDataStore.deleteAllAppointment()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func syncData() {
        print(self.coreDataStore.fetchAppointmentsSyncedFalse())
    }
    
}
