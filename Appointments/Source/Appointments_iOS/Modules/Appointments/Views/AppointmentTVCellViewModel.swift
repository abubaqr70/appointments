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
    var markCheckbox: AnyObserver<Void> { return markcheckboxSubject.asObserver()}
    
    //Mark: Outputs
    var name: Observable<String?> { return nameSubject.asObservable() }
    var room: Observable<String?> { return roomSubject.asObservable() }
    var appointmentDescription: Observable<String?> { return appointmentDescriptionSubject.asObservable() }
    var staff: Observable<String?> { return staffSubject.asObservable() }
    var profileImage: Observable<String?> { return profileImageSubject.asObservable() }
    var markPresent: Observable<Bool> { return markPresentSubject.asObservable()}
    var markPresentEnabled: Observable<Bool> { return markPresentEnabledSubject.asObservable()}
    
    //Mark: Init
    private let disposeBag = DisposeBag()
    let nameSubject: BehaviorSubject<String?>
    let roomSubject: BehaviorSubject<String?>
    let appointmentDescriptionSubject: BehaviorSubject<String?>
    let staffSubject: BehaviorSubject<String?>
    let profileImageSubject: BehaviorSubject<String?>
    let appointmentsSubject: BehaviorSubject<Appointment>
    let markcheckboxSubject : BehaviorSubject<Void>
    let markPresentSubject : BehaviorSubject<Bool>
    let markPresentEnabledSubject : BehaviorSubject<Bool>
    
    init(appointment: Appointment) {
        
        //Mark:- Setting User Names
        markcheckboxSubject = BehaviorSubject(value: ())
        markPresentEnabledSubject = BehaviorSubject(value: true)
        markPresentSubject = BehaviorSubject(value: true)
        appointmentsSubject = BehaviorSubject(value: appointment)
        nameSubject = BehaviorSubject(value: "")
        roomSubject = BehaviorSubject(value: appointment.appointmentAttendance?.first?.user?.roomNo)
        appointmentDescriptionSubject = BehaviorSubject(value: appointment.title)
        if appointment.user != nil {
            staffSubject = BehaviorSubject(value: appointment.user?.fullName)
        }else{
            staffSubject = BehaviorSubject(value: appointment.userGroup?.name)
        }
       
        profileImageSubject = BehaviorSubject(value: appointment.appointmentAttendance?.first?.user?.profileImageRoute)
        
        appointmentsSubject
            .map { appointments -> String in
                appointments.appointmentAttendance.map { appointmentAttendance -> [String] in
                    appointmentAttendance.map{ user -> String in
                        user.user?.fullName ?? ""
                    }
                }?.joined(separator: ", ") ?? ""
            }
            .bind(to: nameSubject)
            .disposed(by: disposeBag)
        
        bindActions(appointment: appointment)
    }
    
}

extension AppointmentTVCellViewModel {
    
    func bindActions(appointment: Appointment) {
        
        markPresentSubject.onNext( appointment.appointmentAttendance?.first?.present == "present" ? false : true )

        markcheckboxSubject
            .withLatestFrom(self.markPresentSubject)
            .map { isPresent -> Bool in
                return !isPresent
            }
            .unwrap()
            .subscribe(onNext: {
                present in
                self.markPresentSubject.onNext(present)
                self.markPresentEnabledSubject.onNext(!present)
            })
            .disposed(by: disposeBag)
        
    }
}

