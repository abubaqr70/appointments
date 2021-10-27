// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxCocoa
import RxSwift

protocol FilterAppointmentsTVCellViewModelInputs {
    
    //TODO :- Inputs here
    var markCheckbox : AnyObserver<Void> { get }
}

protocol FilterAppointmentsTVCellViewModelOutputs {
    
    // Actions:
    var title: Observable<String?> { get }
    var checkFilter : Observable<Bool> { get }
    var staff: Observable<FacilityStaff?> { get }
    var appointmentsType: Observable<AppointmentsType?> { get }
    
}

protocol FilterAppointmentsTVCellViewModelType {
    var inputs: FilterAppointmentsTVCellViewModelInputs { get }
    var outputs: FilterAppointmentsTVCellViewModelOutputs { get }
}

class FilterAppointmentsTVCellViewModel: FilterAppointmentsTVCellViewModelType, FilterAppointmentsTVCellViewModelInputs, FilterAppointmentsTVCellViewModelOutputs,ReuseableCellViewModelType {
    
    var reuseIdentifier: String = FilterAppointmentsTableViewCell.reuseIdentifier
    
    var inputs: FilterAppointmentsTVCellViewModelInputs { return self }
    var outputs: FilterAppointmentsTVCellViewModelOutputs { return self }
    
    //Mark: Inputs
    var markCheckbox: AnyObserver<Void> { return markCheckboxSubject.asObserver() }
    
    //Mark: Outputs
    var title: Observable<String?> { return titleSubject.asObservable() }
    var checkFilter: Observable<Bool> { return checkFilterSubject.asObservable() }
    var staff: Observable<FacilityStaff?> { return staffSubject.asObservable() }
    var appointmentsType: Observable<AppointmentsType?> { return appointmentsTypeSubject.asObservable() }
    
    //Mark: Init
    private let disposeBag = DisposeBag()
    private let titleSubject: BehaviorSubject<String?>
    private let markCheckboxSubject : PublishSubject<Void>
    private let checkFilterSubject : BehaviorSubject<Bool>
    private let staffSubject : PublishSubject<FacilityStaff?>
    private let appointmentsTypeSubject : PublishSubject<AppointmentsType?>
    
    init(facilityStaff: FacilityStaff,appointmentsRepository: AppointmentRepository) {
        
        //Mark:- Setting Properties
        self.titleSubject = BehaviorSubject(value: "\(facilityStaff.firstName ?? "Test Staff") \(facilityStaff.lastName ?? "Name")")
        self.markCheckboxSubject = PublishSubject()
        let selectedFacilityStaff = appointmentsRepository.getFacilityStaffSelectedIds(facilityId: facilityStaff.facilityId ?? 0)
        self.staffSubject = PublishSubject()
        self.appointmentsTypeSubject = PublishSubject()
        self.checkFilterSubject = BehaviorSubject(value: false)
        guard let staffId = facilityStaff.staffId else {return}
        if selectedFacilityStaff.contains(staffId) {
            self.checkFilterSubject.onNext(true)
        } else {
            self.checkFilterSubject.onNext(false)
        }
        self.bindActions(facilityStaff: facilityStaff)
    }
    
    
    init(appointmentsType: AppointmentsType) {
        
        //Mark:- Setting Properties
        self.titleSubject = BehaviorSubject(value: "\(appointmentsType.name ?? "Test Appointments Type")")
        self.markCheckboxSubject = PublishSubject()
        self.checkFilterSubject = BehaviorSubject(value: false)
        self.staffSubject = PublishSubject()
        self.appointmentsTypeSubject = PublishSubject()
        self.bindActions(appointmentsType: appointmentsType)
    }
}

extension FilterAppointmentsTVCellViewModel {
    
    func bindActions(facilityStaff: FacilityStaff) {
        
//        checkFilterSubject.onNext( facilityStaff.isSelected ?? false ? true : false )
        
        markCheckboxSubject
            .withLatestFrom(self.checkFilterSubject)
            .map { isPresent -> Bool in
                return !isPresent
            }
            .unwrap()
            .subscribe(onNext: {
                present in
                self.checkFilterSubject.onNext(present)
                self.staffSubject.onNext(facilityStaff)
            })
            .disposed(by: disposeBag)
        
    }
    
    func bindActions(appointmentsType: AppointmentsType) {
        
        checkFilterSubject.onNext( appointmentsType.isSelected ?? false ? true : false )

        markCheckboxSubject
            .withLatestFrom(self.checkFilterSubject)
            .map { isPresent -> Bool in
                return !isPresent
            }
            .unwrap()
            .subscribe(onNext: {
                present in
                self.checkFilterSubject.onNext(present)
                self.appointmentsTypeSubject.onNext(appointmentsType)
            })
            .disposed(by: disposeBag)
        
    }
}


