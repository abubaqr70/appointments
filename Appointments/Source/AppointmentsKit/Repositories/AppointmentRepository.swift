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
                         endDate: TimeInterval) -> Observable<[AppointmentsResultType]> {
        
        return Observable.create { [weak self] observer in
            
            guard let self = self else { return Disposables.create() }
            
            self.appointmentService.getAppointments(for: facilityID,
                                                    startDate: startDate,
                                                    endDate: endDate) { (result: Result<[Appointment], Error>) in
                
                switch result {
                case .failure(let error):
                    observer.onError(error)
                case .success(let appointments):
                    
                    let appointmentsResult : [AppointmentsResultType] = appointments
                        .map{
                            appointment -> [AppointmentsResultType] in
                            appointment.appointmentAttendance?
                                .map{
                                    attendance -> AppointmentsResultType in
                                    return AppointmentsResultType(id: appointment.id, title: appointment.title, location: appointment.location, description: appointment.description, occurrenceId: appointment.occurrenceId, parentEventId: appointment.parentEventId, appointmentType: appointment.therapyId, startDate: appointment.startDate?.date, endDate: appointment.endDate?.date, startTime: appointment.startDate?.timeString?.replacingOccurrences(of: "[apm]", with: "", options: [.regularExpression, .caseInsensitive]), endTime: appointment.endDate?.timeString, staffName: appointment.user != nil ? appointment.user?.fullName : appointment.userGroup?.name, fullName: attendance.user?.fullName, roomNo: attendance.user?.roomNo, profileImage: attendance.user?.profileImageRoute, residentId: attendance.residentId, present: attendance.present)
                                } ?? []}
                        .flatMap{
                            appointmentsResultType -> [AppointmentsResultType] in
                            appointmentsResultType
                                .map{
                                    appointmentResult -> AppointmentsResultType in
                                    return appointmentResult
                                }
                        }
                    
                    observer.onNext(appointmentsResult)
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }
    }
}
