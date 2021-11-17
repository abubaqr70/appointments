// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxCocoa
import RxSwift

protocol HeaderTVCellViewModelInputs {
    
}

protocol HeaderTVCellViewModelOutputs {
    
    // Actions:
    var name: Observable<String?> { get }
    var room: Observable<String?> { get }
    var time: Observable<String?> { get }
    var profileImage: Observable<String?> { get }
    var authorizedToManageAppointments : Observable<Bool> { get }
    var authorizedToViewTitleAppointments : Observable<Bool> { get }
    var authorizedToViewTitleAndDescriptionAppointments : Observable<Bool> { get }
    
}

protocol HeaderTVCellViewModelType {
    var inputs: HeaderTVCellViewModelInputs { get }
    var outputs: HeaderTVCellViewModelOutputs { get }
}

class HeaderTVCellViewModel: HeaderTVCellViewModelType, HeaderTVCellViewModelInputs, HeaderTVCellViewModelOutputs,ReuseableCellViewModelType {
    var reuseIdentifier: String = AppointmentTableViewCell.reuseIdentifier
    
    var inputs: HeaderTVCellViewModelInputs { return self }
    var outputs: HeaderTVCellViewModelOutputs { return self }
    
    //Mark: Outputs
    var name: Observable<String?> { return nameSubject.asObservable() }
    var room: Observable<String?> { return roomSubject.asObservable() }
    var time: Observable<String?> { return timeSubject.asObservable() }
    var profileImage: Observable<String?> { return profileImageSubject.asObservable() }
    var authorizedToManageAppointments : Observable<Bool> { return authorizedToManageAppointmentsSubject.asObservable() }
    var authorizedToViewTitleAppointments : Observable<Bool> { return authorizedToViewTitleAppointmentsSubject.asObservable() }
    var authorizedToViewTitleAndDescriptionAppointments : Observable<Bool> { return authorizedToViewTitleAndDescriptionAppointmentsSubject.asObservable() }
    
    //Mark: Init
    private let disposeBag = DisposeBag()
    private let nameSubject: BehaviorSubject<String?>
    private let roomSubject: BehaviorSubject<String?>
    private let permissionProvider: PermissionProvider
    private let timeSubject: BehaviorSubject<String?>
    private let profileImageSubject: BehaviorSubject<String?>
    private let authorizedToManageAppointmentsSubject : BehaviorSubject<Bool>
    private let authorizedToViewTitleAppointmentsSubject : BehaviorSubject<Bool>
    private let authorizedToViewTitleAndDescriptionAppointmentsSubject : BehaviorSubject<Bool>
    
    init(appointment: Appointment,permissionProvider: PermissionProvider) {
        
        //Mark:- Setting User Names
        self.permissionProvider = permissionProvider
        authorizedToManageAppointmentsSubject = BehaviorSubject(value: self.permissionProvider.authorizedToManageAppointments)
        authorizedToViewTitleAppointmentsSubject = BehaviorSubject(value: self.permissionProvider.authorizedToViewTitleAppointments)
        authorizedToViewTitleAndDescriptionAppointmentsSubject = BehaviorSubject(value: self.permissionProvider.authorizedToViewTitleAndDescriptionAppointments)
        roomSubject = BehaviorSubject(value: appointment.appointmentAttendance?.first?.user?.roomNo)
        profileImageSubject = BehaviorSubject(value: appointment.appointmentAttendance?.first?.user?.profileImageRoute)
        nameSubject = BehaviorSubject(value: appointment.appointmentAttendance?.first?.user?.fullName)
        timeSubject = BehaviorSubject(value: "\(appointment.startDate?.timeString ?? "") - \(appointment.endDate?.timeString ?? "")")
    }
    
}
