// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxCocoa
import RxSwift

protocol FilterAppointmentsViewModelInputs {
    
    // Actions:
    var appointmentFilterObserver: AnyObserver<Void> { get }
    var clear: AnyObserver<Void> { get }
    var refresh: AnyObserver<Void> { get }
}

protocol FilterAppointmentsViewModelOutputs {
    
    //Outputs
    var filterAppointments: Observable<Void> { get }
    var sections: Observable<[(title: ReuseableCellViewModelType, rows: [ReuseableCellViewModelType])]> { get }
    var isAppointmentsFilterApplied: Observable<Bool> { get }
}

protocol FilterAppointmentsViewModelType {
    var inputs: FilterAppointmentsViewModelInputs { get }
    var outputs: FilterAppointmentsViewModelOutputs { get }
}

class FilterAppointmentsViewModel : FilterAppointmentsViewModelType, FilterAppointmentsViewModelInputs, FilterAppointmentsViewModelOutputs {
    
    var inputs: FilterAppointmentsViewModelInputs { return self }
    var outputs: FilterAppointmentsViewModelOutputs { return self }
    
    var appointmentFilterObserver: AnyObserver<Void> { return appointmentFilterSubject.asObserver() }
    var clear: AnyObserver<Void> { return clearSubject.asObserver() }
    var refresh: AnyObserver<Void> { return refreshSubject.asObserver() }
    
    var filterAppointments: Observable<Void> { return filterAppointmentsSubject.asObservable() }
    var sections: Observable<[(title: ReuseableCellViewModelType, rows: [ReuseableCellViewModelType])]> { return sectionsSubject.asObservable() }
    var isAppointmentsFilterApplied: Observable<Bool> { return isAppointmentsFilterAppliedSubject.asObservable() }
    
    private let appointmentFilterSubject = PublishSubject<Void>()
    private let filterAppointmentsSubject = PublishSubject<Void>()
    private let refreshSubject = PublishSubject<Void>()
    private let refreshAppointmentsTypeSubject = PublishSubject<Void>()
    private let refreshStaffSubject = PublishSubject<Void>()
    private let clearSubject = PublishSubject<Void>()
    private let facilityStaffSubject = BehaviorSubject<[FacilityStaff]>(value: [])
    private let appointmentsTypeSubject = BehaviorSubject<[AppointmentsType]>(value: [])
    private let sectionsSubject = BehaviorSubject<[(title: ReuseableCellViewModelType, rows: [ReuseableCellViewModelType])]>(value: [])
    private let isAppointmentsFilterAppliedSubject = BehaviorSubject<Bool>(value: false)
    
    private let facilityDataStore: FacilityDataStore
    private let appointmentsRepository: AppointmentRepository
    private let disposeBag = DisposeBag()
    
    init(appointmentsRepository: AppointmentRepository,
         facilityDataStore: FacilityDataStore) {
        
        self.appointmentsRepository = appointmentsRepository
        self.facilityDataStore = facilityDataStore
        
        let appointmentsTypeFetchRequest = self.refreshAppointmentsTypeSubject
            .withLatestFrom(self.refreshSubject)
            .flatMap { [weak self] _ -> Observable<Event<([AppointmentsType])>> in
                guard let self = self, let facilityID = self.facilityDataStore.currentFacility?["facility_id"] as? Int else { return .never() }
                return self.appointmentsRepository.getAppointmentsType(for: facilityID)
                    .materialize()
            }
            .share()
        
        appointmentsTypeFetchRequest
            .elements()
            .bind(to: self.appointmentsTypeSubject)
            .disposed(by: disposeBag)
        
        appointmentsTypeFetchRequest.errors()
            .debug("Errors")
            .map{$0.localizedDescription}
            .subscribe(onNext: {error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        self.refreshStaffSubject.withLatestFrom(self.refreshSubject).flatMap{
            _ -> Observable<[FacilityStaff]> in
            return self.appointmentsRepository.getFacilityStaff(for: self.facilityDataStore)
        }.subscribe(onNext: {
            facilityStaff in
            self.facilityStaffSubject.onNext(facilityStaff)
        }).disposed(by: disposeBag)
        
        
        self.refreshSubject
            .subscribe(onNext: {
                _ in
                self.refreshAppointmentsTypeSubject.onNext(Void())
                self.refreshStaffSubject.onNext(Void())
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(self.facilityStaffSubject, self.appointmentsTypeSubject){
            facilityStaff, appointmentsType -> [(title: ReuseableCellViewModelType, rows: [ReuseableCellViewModelType])] in
            print("Facility Staff Selected : \(self.appointmentsRepository.getFacilityStaffSelected().count)")
            print("AppointmentsType Selected : \(self.appointmentsRepository.getAppointmentsTypeSelected().count)")
            self.isAppointmentsFilterAppliedSubject.onNext(self.appointmentsRepository.isAppointmentsFilterApplied())
            return self.createFilterTableViewSections(facilityStaff: facilityStaff, appointmentsType: appointmentsType)
        }
        .bind(to: self.sectionsSubject)
        .disposed(by: disposeBag)
        
        bindActions()
        
    }
    
}

extension FilterAppointmentsViewModel {
    
    func createFilterTableViewSections(facilityStaff: [FacilityStaff],
                                       appointmentsType: [AppointmentsType] ) -> [(title: ReuseableCellViewModelType, rows: [ReuseableCellViewModelType])]{
        let allCategoriesSection = self.createAllCategoriesSection()
        let staffSection = self.createStaffSection(facilityStaff: facilityStaff)
        let appointmentTypeSection = self.createAppointmentsTypeSection(appointmentsType: appointmentsType)
        
        return [allCategoriesSection,appointmentTypeSection,staffSection]
    }
    
    func createAllCategoriesSection() -> (title: ReuseableCellViewModelType, rows: [ReuseableCellViewModelType]) {
        
        let selected: Bool
        if self.appointmentsRepository.checkForMarkFacilityStaff(for: self.facilityDataStore) && self.appointmentsRepository.checkForMarkAppointmentsType() {
            selected = true
        } else {
            selected = false
        }
        
        let headerViewModel = FilterHeaderTVCellViewModel(headerTitle: "All Categories", isSelectedAll: selected)
        
        headerViewModel.outputs.headerType.subscribe(onNext: {
            headerTitle in
            
            if self.appointmentsRepository.checkForMarkFacilityStaff(for: self.facilityDataStore) && self.appointmentsRepository.checkForMarkAppointmentsType() {
                self.markAllCategories(status: false)
            } else {
                self.markAllCategories(status: true)
            }
            self.refreshSubject.onNext(Void())
        }).disposed(by: disposeBag)
        
        return (headerViewModel, [])
    }
    
    func createStaffSection(facilityStaff: [FacilityStaff]) -> (title: ReuseableCellViewModelType, rows: [ReuseableCellViewModelType]) {
        
        let selected: Bool
        if self.appointmentsRepository.checkForMarkFacilityStaff(for: facilityDataStore) {
            selected = true
        } else {
            selected = false
        }
        
        let headerViewModel = FilterHeaderTVCellViewModel(headerTitle: "All Staff", isSelectedAll: selected)
        
        headerViewModel.outputs.headerType.subscribe(onNext: {
            headerTitle in
            if self.appointmentsRepository.checkForMarkFacilityStaff(for: self.facilityDataStore) {
                self.appointmentsRepository.markAllFacilityStaffStatus(for: self.facilityDataStore, status: false)
            } else {
                self.appointmentsRepository.markAllFacilityStaffStatus(for: self.facilityDataStore, status: true)
            }
            self.refreshSubject.onNext(Void())
        }).disposed(by: disposeBag)
        
        let cellViewModel : [ReuseableCellViewModelType] = facilityStaff.map { staff -> ReuseableCellViewModelType in
            let cellViewModel = FilterAppointmentsTVCellViewModel(facilityStaff: staff,appointmentsRepository: self.appointmentsRepository)
            cellViewModel.outputs.staff.subscribe(onNext: {
                staff in
                guard let staff = staff else {return}
                self.appointmentsRepository.markFacilityStaff(facilityStaff: staff)
                self.refreshSubject.onNext(Void())
            })
            .disposed(by: disposeBag)
            return cellViewModel
        }
        
        return (headerViewModel, cellViewModel)
    }
    
    func createAppointmentsTypeSection(appointmentsType: [AppointmentsType]) -> (title: ReuseableCellViewModelType, rows: [ReuseableCellViewModelType]) {
        
        let selected: Bool
        if self.appointmentsRepository.checkForMarkAppointmentsType() {
            selected = true
        } else {
            selected = false
        }
        
        let headerViewModel = FilterHeaderTVCellViewModel(headerTitle: "All Appointment Type", isSelectedAll: selected)
        
        headerViewModel.outputs.headerType.subscribe(onNext: {
            headerTitle in
            if self.appointmentsRepository.checkForMarkAppointmentsType() {
                self.appointmentsRepository.markAllAppointmentsTypeStatus(status: false)
            } else {
                self.appointmentsRepository.markAllAppointmentsTypeStatus(status: true)
            }
            self.refreshSubject.onNext(Void())
        }).disposed(by: disposeBag)
        
        let cellViewModel : [ReuseableCellViewModelType] = appointmentsType.map { appointmentType -> ReuseableCellViewModelType in
            let cellViewModel = FilterAppointmentsTVCellViewModel(appointmentsType: appointmentType)
            cellViewModel.outputs.appointmentsType.subscribe(onNext: {
                appointmentType in
                guard let appointmentType = appointmentType else {return}
                self.appointmentsRepository.markAppointmentsType(appointmentType: appointmentType)
                self.refreshSubject.onNext(Void())
            })
            .disposed(by: disposeBag)
            return cellViewModel
        }
        
        return (headerViewModel, cellViewModel)
    }
    
    func markAllCategories(status: Bool) {
        self.appointmentsRepository.markAllFacilityStaffStatus(for: self.facilityDataStore, status: status)
        self.appointmentsRepository.markAllAppointmentsTypeStatus(status: status)
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
        
        clearSubject.subscribe(onNext: {
            _ in
            print("Clear")
            self.markAllCategories(status: false)
            self.refreshSubject.onNext(Void())
        }).disposed(by: disposeBag)
        
    }
}

