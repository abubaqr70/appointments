// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxCocoa
import RxSwift

protocol AppointmentTVCellViewModelInputs {
    
    //TODO :- Inputs here
}

protocol AppointmentTVCellViewModelOutputs {
    
    // Actions:
    var name: Observable<String?> { get }
    var room: Observable<String?> { get }
    var appointmentDescription: Observable<String?> { get }
    var staff: Observable<String?> { get }
    var profileImage: Observable<String?> { get }
    
}

protocol AppointmentTVCellViewModelType {
    var inputs: AppointmentTVCellViewModelInputs { get }
    var outputs: AppointmentTVCellViewModelOutputs { get }
}

class AppointmentTVCellViewModel: AppointmentTVCellViewModelType, AppointmentTVCellViewModelInputs, AppointmentTVCellViewModelOutputs,ReuseableCellViewModelType {
    
    var reuseIdentifier: String = AppointmentTableViewCell.reuseIdentifier
    
    var inputs: AppointmentTVCellViewModelInputs { return self }
    var outputs: AppointmentTVCellViewModelOutputs { return self }
    
    //Mark: Outputs
    var name: Observable<String?> { return nameSubject.asObservable() }
    var room: Observable<String?> { return roomSubject.asObservable() }
    var appointmentDescription: Observable<String?> { return appointmentDescriptionSubject.asObservable() }
    var staff: Observable<String?> { return staffSubject.asObservable() }
    var profileImage: Observable<String?> { return profileImageSubject.asObservable() }
    
    //Mark: Init
    private let disposeBag = DisposeBag()
    let nameSubject: BehaviorSubject<String?>
    let roomSubject: BehaviorSubject<String?>
    let appointmentDescriptionSubject: BehaviorSubject<String?>
    let staffSubject: BehaviorSubject<String?>
    let profileImageSubject: BehaviorSubject<String?>
    let appointmentsSubject: BehaviorSubject<Appointment>
    
    init(appointment: Appointment) {
        
        //Mark:- Setting User Names
        appointmentsSubject = BehaviorSubject(value: appointment)
        nameSubject = BehaviorSubject(value: "")
        roomSubject = BehaviorSubject(value: appointment.appointmentAttendance?.first?.user?.v_room_no)
        appointmentDescriptionSubject = BehaviorSubject(value: appointment.v_title)
        staffSubject = BehaviorSubject(value: appointment.user?.fullname)
        profileImageSubject = BehaviorSubject(value: appointment.appointmentAttendance?.first?.user?.profileImageRoute)
        
        appointmentsSubject
            .map { appointments -> String in
                appointments.appointmentAttendance.map { appointmentAttendance -> [String] in
                    appointmentAttendance.map{ user -> String in
                        user.user?.fullname ?? ""
                    }
                }?.joined(separator: ", ") ?? ""
            }
            .bind(to: nameSubject)
            .disposed(by: disposeBag)
    }
    
}

