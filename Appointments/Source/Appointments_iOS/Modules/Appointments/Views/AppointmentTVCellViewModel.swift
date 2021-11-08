// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxCocoa
import RxSwift

protocol AppointmentTVCellViewModelInputs {
    
    //TODO :- Inputs here
    var markCheckbox : AnyObserver<Void> { get }
}

protocol AppointmentTVCellViewModelOutputs {
    
    // Actions:
    var name: Observable<String?> { get }
    var room: Observable<String?> { get }
    var appointmentDescription: Observable<String?> { get }
    var staff: Observable<String?> { get }
    var profileImage: Observable<String?> { get }
    var markPresent : Observable<Bool> { get }
    var markPresentEnabled : Observable<Bool> { get }
    var appointment: Observable<Appointment> { get }
    var markAppointment: Observable<Appointment> { get }
    var authorizedToManageAppointments : Observable<Bool> { get }
    var authorizedToViewTitleAppointments : Observable<Bool> { get }
    var authorizedToViewTitleAndDescriptionAppointments : Observable<Bool> { get }
    
}

protocol AppointmentTVCellViewModelType {
    var inputs: AppointmentTVCellViewModelInputs { get }
    var outputs: AppointmentTVCellViewModelOutputs { get }
}

class AppointmentTVCellViewModel: AppointmentTVCellViewModelType, AppointmentTVCellViewModelInputs, AppointmentTVCellViewModelOutputs,ReuseableCellViewModelType {
    
    var reuseIdentifier: String = AppointmentTableViewCell.reuseIdentifier
    
    var inputs: AppointmentTVCellViewModelInputs { return self }
    var outputs: AppointmentTVCellViewModelOutputs { return self }
    
    //Mark: Inputs
    var markCheckbox: AnyObserver<Void> { return markCheckboxSubject.asObserver() }
    
    //Mark: Outputs
    var name: Observable<String?> { return nameSubject.asObservable() }
    var room: Observable<String?> { return roomSubject.asObservable() }
    var appointmentDescription: Observable<String?> { return appointmentDescriptionSubject.asObservable() }
    var staff: Observable<String?> { return staffSubject.asObservable() }
    var profileImage: Observable<String?> { return profileImageSubject.asObservable() }
    var markPresent: Observable<Bool> { return markPresentSubject.asObservable() }
    var markPresentEnabled: Observable<Bool> { return markPresentEnabledSubject.asObservable() }
    var appointment: Observable<Appointment> { return appointmentsSubject.asObservable() }
    var markAppointment: Observable<Appointment> { return markAppointmentSubject.asObservable() }
    var authorizedToManageAppointments : Observable<Bool> { return authorizedToManageAppointmentsSubject.asObservable() }
    var authorizedToViewTitleAppointments : Observable<Bool> { return authorizedToViewTitleAppointmentsSubject.asObservable() }
    var authorizedToViewTitleAndDescriptionAppointments : Observable<Bool> { return authorizedToViewTitleAndDescriptionAppointmentsSubject.asObservable() }
    
    //Mark: Init
    private let disposeBag = DisposeBag()
    private let nameSubject: BehaviorSubject<String?>
    private let roomSubject: BehaviorSubject<String?>
    private let permissionProvider: PermissionProvider
    private let appointmentDescriptionSubject: BehaviorSubject<String?>
    private let staffSubject: BehaviorSubject<String?>
    private let profileImageSubject: BehaviorSubject<String?>
    private let appointmentsSubject: BehaviorSubject<Appointment>
    private let markCheckboxSubject : PublishSubject<Void>
    private let markPresentSubject : BehaviorSubject<Bool>
    private let markPresentEnabledSubject : BehaviorSubject<Bool>
    private let markAppointmentSubject : PublishSubject<Appointment>
    private let authorizedToManageAppointmentsSubject : BehaviorSubject<Bool>
    private let authorizedToViewTitleAppointmentsSubject : BehaviorSubject<Bool>
    private let authorizedToViewTitleAndDescriptionAppointmentsSubject : BehaviorSubject<Bool>
    
    init(appointment: Appointment,permissionProvider: PermissionProvider) {
        
        //Mark:- Setting User Names
        self.permissionProvider = permissionProvider
        authorizedToManageAppointmentsSubject = BehaviorSubject(value: self.permissionProvider.authorizedToManageAppointments)
        authorizedToViewTitleAppointmentsSubject = BehaviorSubject(value: self.permissionProvider.authorizedToViewTitleAppointments)
        authorizedToViewTitleAndDescriptionAppointmentsSubject = BehaviorSubject(value: self.permissionProvider.authorizedToViewTitleAndDescriptionAppointments)
        markCheckboxSubject = PublishSubject()
        markAppointmentSubject = PublishSubject()
        markPresentEnabledSubject = BehaviorSubject(value: true)
        markPresentSubject = BehaviorSubject(value: true)
        appointmentsSubject = BehaviorSubject(value: appointment)
        roomSubject = BehaviorSubject(value: appointment.appointmentAttendance?.first?.user?.roomNo)
        appointmentDescriptionSubject = BehaviorSubject(value: appointment.title)
        if appointment.userGroup != nil {
            staffSubject = BehaviorSubject(value: appointment.userGroup?.name)
        } else {
            staffSubject = BehaviorSubject(value: appointment.user?.fullName)
        }
        profileImageSubject = BehaviorSubject(value: appointment.appointmentAttendance?.first?.user?.profileImageRoute)
        nameSubject = BehaviorSubject(value: appointment.appointmentAttendance?.first?.user?.fullName)
        bindActions(appointment: appointment)
        
    }
    
}

extension AppointmentTVCellViewModel {
    
    func bindActions(appointment: Appointment) {
        
        markPresentSubject.onNext( appointment.appointmentAttendance?.first?.present == "present" ? true : false )
        
        self.markPresentSubject.map { isPresent -> Bool in
            
            if self.permissionProvider.authorizedToManageAppointments {
                if TimeInterval(Float(appointment.startingDate ?? 0.0)) > Date().timeIntervalSince1970 && !isPresent  {
                    return false
                } else if isPresent {
                    return false
                } else {
                    return true
                }
            } else {
                return false
            }
        }
        .bind(to: self.markPresentEnabledSubject)
        .disposed(by: disposeBag)
        
        markCheckboxSubject
            .withLatestFrom(self.markPresentSubject)
            .map { isPresent -> Bool in
                return !isPresent
            }
            .unwrap()
            .subscribe(onNext: {
                present in
                self.markPresentSubject.onNext(present)
                self.markAppointmentSubject.onNext(appointment)
            })
            .disposed(by: disposeBag)
        
        
        
    }
}

