// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxSwift

class AppointmentRepository {
    
    let appointmentService: AppointmentService
    
    init(appointmentService: AppointmentService) {
        self.appointmentService = appointmentService
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
                    observer.onNext(appointments)
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }
    }
}
