// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxSwift
import RxSwiftExt

protocol AppointmentDetailViewModelInputs {
    
    // Actions:
    var markPresent: AnyObserver<Void> { get }
    
}

protocol AppointmentDetailViewModelOutputs {
    
    // Actions:
    var name: Observable<String?> { get }
    var room: Observable<String?> { get }
    var appointmentTitle: Observable<String?> { get }
    var appointmentDescription: Observable<NSAttributedString?> { get }
    var appointmentType: Observable<NSAttributedString?> { get }
    var location: Observable<NSAttributedString?> { get }
    var date: Observable<String?> { get }
    var time: Observable<String?> { get }
    var staff: Observable<NSAttributedString?> { get }
    var profileImage: Observable<String?> { get }
    var isPresent : Observable<Bool> { get }
    
}

protocol AppointmentDetailViewModelType {
    var inputs: AppointmentDetailViewModelInputs { get }
    var outputs: AppointmentDetailViewModelOutputs { get }
}

class AppointmentDetailViewModel: AppointmentDetailViewModelType, AppointmentDetailViewModelInputs, AppointmentDetailViewModelOutputs {
    
    var inputs: AppointmentDetailViewModelInputs { return self }
    var outputs: AppointmentDetailViewModelOutputs { return self }
    
    //Mark: Inputs
    var markPresent: AnyObserver<Void> { return markPresentSubject.asObserver()}
    
    //Mark: Outputs
    var name: Observable<String?> { return nameSubject.asObservable() }
    var room: Observable<String?> { return roomSubject.asObservable() }
    var appointmentTitle: Observable<String?> { return appointmentTitleSubject.asObservable() }
    var appointmentType: Observable<NSAttributedString?> { return appointmentTypeSubject.asObservable() }
    var appointmentDescription: Observable<NSAttributedString?> { return appointmentDescriptionSubject.asObservable() }
    var location: Observable<NSAttributedString?> { return locationSubject.asObservable() }
    var date: Observable<String?> { return dateSubject.asObservable() }
    var time: Observable<String?> { return timeSubject.asObservable() }
    var staff: Observable<NSAttributedString?> { return staffSubject.asObservable() }
    var profileImage: Observable<String?> { return profileImageSubject.asObservable() }
    var isPresent: Observable<Bool> { return isPresentSubject.asObservable()}
    
    //Mark: Private Properties
    
    //Mark: Init
    private let disposeBag = DisposeBag()
    private let nameSubject: BehaviorSubject<String?>
    private let roomSubject: BehaviorSubject<String?>
    private let appointmentTitleSubject: BehaviorSubject<String?>
    private let appointmentTypeSubject: BehaviorSubject<NSAttributedString?>
    private let appointmentDescriptionSubject: BehaviorSubject<NSAttributedString?>
    private let locationSubject: BehaviorSubject<NSAttributedString?>
    private let dateSubject: BehaviorSubject<String?>
    private let timeSubject: BehaviorSubject<String?>
    private let staffSubject: BehaviorSubject<NSAttributedString?>
    private let profileImageSubject: BehaviorSubject<String?>
    private let appointmentsSubject: BehaviorSubject<Appointment>
    private let markPresentSubject : BehaviorSubject<Void>
    private let isPresentSubject : BehaviorSubject<Bool>
    
    
    init(appointment: Appointment,repository: AppointmentRepository){
       
        //Mark:- Setting User Names
        markPresentSubject = BehaviorSubject(value: ())
        isPresentSubject = BehaviorSubject(value: true)
        appointmentsSubject = BehaviorSubject(value: appointment)
        nameSubject = BehaviorSubject(value: appointment.appointmentAttendance?.first?.user?.fullName)
        roomSubject = BehaviorSubject(value: appointment.appointmentAttendance?.first?.user?.roomNo)
        appointmentTitleSubject = BehaviorSubject(value: appointment.title)
        appointmentDescriptionSubject = BehaviorSubject(value: appointment.description?.htmlToAttributedString)
        appointmentTypeSubject = BehaviorSubject(value: NSAttributedString(string: ""))
        locationSubject = BehaviorSubject(value: NSAttributedString(string: ""))
        staffSubject = BehaviorSubject(value: NSAttributedString(string: ""))
        dateSubject = BehaviorSubject(value: "")
        timeSubject = BehaviorSubject(value: "")
        
            appointmentsSubject
                .map { appointments -> NSMutableAttributedString in
                    let attributedString = NSMutableAttributedString(string: "Staff: \(appointments.startDate?.date ?? "")", attributes: [
                        .font: UIFont.appFont(withStyle: .title3, size: 14)
                    ])
                    attributedString.addAttribute(.font, value: UIFont.appFont(withStyle: .largeTitle, size: 14), range: NSRange(location: 0, length: 6))
                    return attributedString
                }
                .bind(to: staffSubject)
                .disposed(by: disposeBag)
        
        
        appointmentsSubject
            .map { appointments -> NSMutableAttributedString in
                let attributedString = NSMutableAttributedString(string: "Location: \(appointments.location ?? "")", attributes: [
                    .font: UIFont.appFont(withStyle: .title3, size: 14)
                ])
                attributedString.addAttribute(.font, value: UIFont.appFont(withStyle: .largeTitle, size: 14), range: NSRange(location: 0, length: 9))
                return attributedString
            }
            .bind(to: locationSubject)
            .disposed(by: disposeBag)
        
        appointmentsSubject
            .map { appointments -> NSMutableAttributedString in
                let attributedString = NSMutableAttributedString(string: "Appointment Type: \(appointments.therapyId ?? 0)", attributes: [
                    .font: UIFont.appFont(withStyle: .title3, size: 14),
                ])
                attributedString.addAttribute(.font, value: UIFont.appFont(withStyle: .largeTitle, size: 14), range: NSRange(location: 0, length: 17))
                return attributedString
            }
            .bind(to: appointmentTypeSubject)
            .disposed(by: disposeBag)
        
        profileImageSubject = BehaviorSubject(value: appointment.appointmentAttendance?.first?.user?.profileImageRoute)
        
       
        appointmentsSubject
            .map({
                appointments -> String in
                let dateFormatterFromString = DateFormatter()
                dateFormatterFromString.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
                let date = dateFormatterFromString.date(from: appointment.startDate?.date ?? "")
                let dateFormatterFromDate = DateFormatter()
                dateFormatterFromDate.dateFormat = "EEEE, MMM dd, yyyy"
                return dateFormatterFromDate.string(from: date ?? Date())
            })
            .bind(to: dateSubject)
            .disposed(by: disposeBag)
        
        appointmentsSubject
            .map({
                appointments -> String in
                return "\(appointment.startDate?.timeString ?? "") - \(appointment.endDate?.timeString ?? "")"
            })
            .bind(to: timeSubject)
            .disposed(by: disposeBag)
        
        bindActions(appointment: appointment)
    }
    
}

extension AppointmentDetailViewModel {
    
    func bindActions(appointment: Appointment) {
        
        isPresentSubject.onNext( appointment.appointmentAttendance?.first?.present == "present" ? false : true )
        
        markPresentSubject
            .withLatestFrom(self.isPresent)
            .map { isPresent -> Bool in
                return !isPresent
            }
            .unwrap()
            .subscribe(onNext: {
                present in
                self.isPresentSubject.onNext(present)
            })
            .disposed(by: disposeBag)
        
    }
}


