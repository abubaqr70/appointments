// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxCocoa
import RxSwift

protocol FilterAppointmentsViewModelInputs {
    
    // Actions:
    var appointmentFilterObserver: AnyObserver<Void> { get }
}

protocol FilterAppointmentsViewModelOutputs {
    
    //Outputs
    var filterAppointments: Observable<Void> { get }
}

protocol FilterAppointmentsViewModelType {
    var inputs: FilterAppointmentsViewModelInputs { get }
    var outputs: FilterAppointmentsViewModelOutputs { get }
}

class FilterAppointmentsViewModel : FilterAppointmentsViewModelType, FilterAppointmentsViewModelInputs, FilterAppointmentsViewModelOutputs {
    
    var inputs: FilterAppointmentsViewModelInputs { return self }
    var outputs: FilterAppointmentsViewModelOutputs { return self }
    
    var appointmentFilterObserver: AnyObserver<Void> { return appointmentFilterSubject.asObserver() }
    
    var filterAppointments: Observable<Void> { return filterAppointmentsSubject.asObservable() }
    
    private let appointmentFilterSubject = PublishSubject<Void>()
    private let filterAppointmentsSubject = PublishSubject<Void>()
    
    
    private let facilityDataStore: FacilityDataStore
    private let appointmentsRepository: AppointmentRepository
    private let disposeBag = DisposeBag()
    
    init(appointmentsRepository: AppointmentRepository,
         facilityDataStore: FacilityDataStore) {
        
        self.appointmentsRepository = appointmentsRepository
        self.facilityDataStore = facilityDataStore
        
        self.appointmentsRepository.getFacilityStaff(for: self.facilityDataStore)
            .subscribe(onNext: {
                facilityStaff in
                print("Facility staff = \(facilityStaff)")
            }).disposed(by: disposeBag)
        
        self.appointmentsRepository.getAppointmentsType(for: self.facilityDataStore.currentFacility?["id"] as? Int ?? 0)
            .subscribe(onNext: {
                facilityStaff in
                print("Appointments Type = \(facilityStaff)")
            }).disposed(by: disposeBag)
        
        bindActions()
        
    }
    
}

extension FilterAppointmentsViewModel {
    
    func bindActions() {
        
        appointmentFilterSubject
            .subscribe(onNext: { _ in
                print("Appointments Navigation Filter Tap ")
                self.filterAppointmentsSubject.onNext(Void())
            })
            .disposed(by: disposeBag)
        
    }
}

