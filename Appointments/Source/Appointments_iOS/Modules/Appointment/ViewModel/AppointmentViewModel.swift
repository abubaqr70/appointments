// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxSwift
import RxSwiftExt

protocol AppointmentViewModelInputs {
    
    // Actions:
    var markPresent: AnyObserver<Void> { get }
    
}

protocol AppointmentViewModelOutputs {
    
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
    var markPresentEnabled : Observable<Bool> { get }
    var isPresent : Observable<Bool> { get }
    var authorizedToManageAppointments : Observable<Bool> { get }
    var authorizedToViewTitleAppointments : Observable<Bool> { get }
    var authorizedToViewTitleAndDescriptionAppointments : Observable<Bool> { get }
    var isLoading: Observable<Bool> { get }
    
}

protocol AppointmentViewModelType {
    var inputs: AppointmentViewModelInputs { get }
    var outputs: AppointmentViewModelOutputs { get }
}

class AppointmentViewModel: AppointmentViewModelType, AppointmentViewModelInputs, AppointmentViewModelOutputs {
    
    var inputs: AppointmentViewModelInputs { return self }
    var outputs: AppointmentViewModelOutputs { return self }
    
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
    var markPresentEnabled: Observable<Bool> { return markPresentEnabledSubject.asObservable() }
    var authorizedToManageAppointments : Observable<Bool> { return authorizedToManageAppointmentsSubject.asObservable() }
    var authorizedToViewTitleAppointments : Observable<Bool> { return authorizedToViewTitleAppointmentsSubject.asObservable() }
    var authorizedToViewTitleAndDescriptionAppointments : Observable<Bool> { return authorizedToViewTitleAndDescriptionAppointmentsSubject.asObservable() }
    var isLoading: Observable<Bool> { return loadingSubject.asObservable() }
    
    //Mark: Private Properties
    
    //Mark: Init
    private let disposeBag = DisposeBag()
    private let nameSubject: BehaviorSubject<String?>
    private let roomSubject: BehaviorSubject<String?>
    private let permissionProvider: PermissionProvider
    private let appointmentTitleSubject: BehaviorSubject<String?>
    private let appointmentTypeSubject: BehaviorSubject<NSAttributedString?>
    private let appointmentDescriptionSubject: BehaviorSubject<NSAttributedString?>
    private let locationSubject: BehaviorSubject<NSAttributedString?>
    private let dateSubject: BehaviorSubject<String?>
    private let timeSubject: BehaviorSubject<String?>
    private let staffSubject: BehaviorSubject<NSAttributedString?>
    private let profileImageSubject: BehaviorSubject<String?>
    private let appointmentsSubject: BehaviorSubject<Appointment>
    private let markPresentSubject : PublishSubject<Void>
    private let isPresentSubject : BehaviorSubject<Bool>
    private let markPresentEnabledSubject : BehaviorSubject<Bool>
    private let appointmentsRepository: AppointmentRepository
    private let authorizedToManageAppointmentsSubject : BehaviorSubject<Bool>
    private let authorizedToViewTitleAppointmentsSubject : BehaviorSubject<Bool>
    private let authorizedToViewTitleAndDescriptionAppointmentsSubject : BehaviorSubject<Bool>
    private let appointmentsTypeSubject = BehaviorSubject<[AppointmentsType]>(value: [])
    private let loadingSubject = BehaviorSubject<Bool>(value: false)
    
    init(appointment: Appointment,repository: AppointmentRepository,permissionProvider: PermissionProvider){
        
        //Mark:- Setting User Names
        self.permissionProvider = permissionProvider
        self.appointmentsRepository = repository
        markPresentSubject = PublishSubject()
        authorizedToManageAppointmentsSubject = BehaviorSubject(value: self.permissionProvider.authorizedToManageAppointments)
        authorizedToViewTitleAppointmentsSubject = BehaviorSubject(value: self.permissionProvider.authorizedToViewTitleAppointments)
        authorizedToViewTitleAndDescriptionAppointmentsSubject = BehaviorSubject(value: self.permissionProvider.authorizedToViewTitleAndDescriptionAppointments)
        isPresentSubject = BehaviorSubject(value: true)
        appointmentsSubject = BehaviorSubject(value: appointment)
        nameSubject = BehaviorSubject(value: appointment.appointmentAttendance?.first?.user?.fullName)
        roomSubject = BehaviorSubject(value: appointment.appointmentAttendance?.first?.user?.roomNo)
        appointmentTitleSubject = BehaviorSubject(value: appointment.title)
        appointmentDescriptionSubject = BehaviorSubject(value: appointment.description?.convertHtmlToAttributedStringWithFont(font: UIFont.appFont(withStyle: .title2, size: 10)))
        markPresentEnabledSubject = BehaviorSubject(value: true)
        appointmentTypeSubject = BehaviorSubject(value: NSAttributedString(string: ""))
        locationSubject = BehaviorSubject(value: NSAttributedString(string: ""))
        staffSubject = BehaviorSubject(value: NSAttributedString(string: ""))
        dateSubject = BehaviorSubject(value: "")
        timeSubject = BehaviorSubject(value: "")
        
        appointmentsSubject
            .map { appointments -> NSMutableAttributedString in
                var attributedString = NSMutableAttributedString()
                if appointments.userGroup != nil {
                    attributedString = NSMutableAttributedString(string: "Staff: \(appointments.userGroup?.name ?? "")", attributes: [
                        .font: UIFont.appFont(withStyle: .title2, size: 14)
                    ])
                } else {
                    attributedString = NSMutableAttributedString(string: "Staff: \(appointments.user?.firstName ?? "") \(appointments.user?.lastName ?? "")", attributes: [
                        .font: UIFont.appFont(withStyle: .title2, size: 14)
                    ])
                }
                attributedString.addAttribute(.font, value: UIFont.appFont(withStyle: .body, size: 14), range: NSRange(location: 0, length: 6))
                return attributedString
            }
            .bind(to: staffSubject)
            .disposed(by: disposeBag)
        
        
        appointmentsSubject
            .map { appointments -> NSMutableAttributedString in
                let attributedString = NSMutableAttributedString(string: "Location: \(appointments.location ?? "")", attributes: [
                    .font: UIFont.appFont(withStyle: .title2, size: 14)
                ])
                attributedString.addAttribute(.font, value: UIFont.appFont(withStyle: .body, size: 14), range: NSRange(location: 0, length: 9))
                return attributedString
            }
            .bind(to: locationSubject)
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
        
        Observable.combineLatest(appointmentsSubject, self.appointmentsRepository.getAppointmentsType(for: appointment.facilityId ?? 0))
            .map { appointments, appointmentsType -> NSMutableAttributedString in
                
                let appointmentType : [AppointmentsType] = appointmentsType.filter{
                    appointment in
                    appointment.id == appointments.therapyId
                }
                
                let type : String
                if appointmentType.isEmpty {
                    type = ""
                } else {
                    type = appointmentType.first?.name ?? ""
                }
                
                let attributedString = NSMutableAttributedString(string: "Appointment Type: \(type)", attributes: [
                    .font: UIFont.appFont(withStyle: .title2, size: 14),
                ])
                attributedString.addAttribute(.font, value: UIFont.appFont(withStyle: .body, size: 14), range: NSRange(location: 0, length: 17))
                return attributedString
            }
            .bind(to: appointmentTypeSubject)
            .disposed(by: disposeBag)
        
        bindActions(appointment: appointment)
    }
    
}

extension AppointmentViewModel {
    
    func bindActions(appointment: Appointment) {
        
        isPresentSubject.onNext( appointment.appointmentAttendance?.first?.present == "present" ? true : false )
        
        markPresentSubject
            .withLatestFrom(self.isPresentSubject)
            .map { isPresent -> Bool in
                return !isPresent
            }
            .unwrap()
            .subscribe(onNext: {
                present in
                self.isPresentSubject.onNext(present)
                self.appointmentsRepository.updateAppointment(appointment)
                let reachability = ReachabilityService()
                switch reachability.reachabilityType {
                    
                    //Mark:- Internet Connected
                case .connected:
                    self.loadingSubject.onNext(true)
                    self.appointmentsRepository.localFacilitySyncData(facilityId: appointment.facilityId ?? 0)
                    {
                        (result: Result<Void,Error>) in
                        switch result {
                        case .failure (let error) :
                            self.loadingSubject.onNext(false)
                            print(error.localizedDescription)
                        case .success (_):
                            print("success")
                            self.loadingSubject.onNext(false)
                        }
                    }
                case.disconnected:
                    break
                }
                
            })
            .disposed(by: disposeBag)
        
        if TimeInterval(Float(appointment.startingDate ?? 0.0)) > Date().timeIntervalSince1970 {
            markPresentEnabledSubject.onNext(false)
        }else{
            markPresentEnabledSubject.onNext(true)
            markPresentEnabledSubject.onNext(self.permissionProvider.authorizedToManageAppointments)
        }
    }
}


