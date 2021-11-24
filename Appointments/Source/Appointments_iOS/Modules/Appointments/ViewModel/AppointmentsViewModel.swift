// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxSwift
import RxSwiftExt

protocol AppointmentsViewModelInputs {
    
    // Actions:
    var previousDateObserver: AnyObserver<Void> { get }
    var nextDateObserver: AnyObserver<Void> { get }
    var datePickerObserver: AnyObserver<Date> { get }
    var segmentControlObserver: AnyObserver<Int> { get }
    var appointmentFilterObserver: AnyObserver<Void> { get }
    var filterObserver: AnyObserver<Void> { get }
    var selectAppointment: AnyObserver<Appointment> { get }
    var viewWillAppear: AnyObserver<Bool> { get }
    var refreshControl: AnyObserver<Void> { get }
    
}

protocol AppointmentsViewModelOutputs {
    
    //Sections
    var sections: Observable<[(title: ReuseableCellViewModelType, rows: [ReuseableCellViewModelType])]> { get }
    var selectedAppointment: Observable<Appointment> { get }
    
    // Actions:
    var lastUpdatedLabel: Observable<NSAttributedString?> { get }
    var dateNavigatorTitle: Observable<String?> { get }
    var errorAlert: Observable<String> { get }
    var isLoading: Observable<Bool> { get }
    var filterAppointments: Observable<Void> { get }
    var isRefreshing: Observable<Bool> { get }
    var isResident: Observable<Bool> { get }
    var residentName: Observable<String> { get }
    var residentImage: Observable<String> { get }
    var residentRoom: Observable<String> { get }
    var isFilterApplied: Observable<Bool> { get }
    var isAppointmentsFilterApplied: Observable<Bool> { get }
    var progress: Observable<Float> { get }
    var facilityDataStoreOutput: FacilityDataStore { get }
}

protocol AppointmentsViewModelType {
    var inputs: AppointmentsViewModelInputs { get }
    var outputs: AppointmentsViewModelOutputs { get }
}

class AppointmentsViewModel: AppointmentsViewModelType, AppointmentsViewModelInputs, AppointmentsViewModelOutputs {
    
    var inputs: AppointmentsViewModelInputs { return self }
    var outputs: AppointmentsViewModelOutputs { return self }
    
    //Mark: Inputs
    var previousDateObserver: AnyObserver<Void> { return previousDateSubject.asObserver() }
    var nextDateObserver: AnyObserver<Void> { return nextDateSubject.asObserver() }
    var datePickerObserver: AnyObserver<Date> { return datePickerSubject.asObserver() }
    var segmentControlObserver: AnyObserver<Int> { return segmentControlSubject.asObserver() }
    var appointmentFilterObserver: AnyObserver<Void> { return appointmentFilterSubject.asObserver() }
    var filterObserver: AnyObserver<Void> { return filterSubject.asObserver() }
    var selectAppointment: AnyObserver<Appointment> { return selectAppointmentSubject.asObserver() }
    var viewWillAppear: AnyObserver<Bool> { return refreshAppointmentsSubject.asObserver() }
    var refreshControl: AnyObserver<Void> { return refreshControlSubject.asObserver() }
    
    //Mark: Outputs
    var lastUpdatedLabel: Observable<NSAttributedString?> { return  lastUpdatedLabelSubject.asObservable() }
    var dateNavigatorTitle: Observable<String?> { return  dateNavigatorTitleSubject.asObservable() }
    var filterAppointments: Observable<Void> { return filterAppointmentsSubject.asObservable() }
    var errorAlert: Observable<String> { return errorAlertSubject.asObservable() }
    var isLoading: Observable<Bool> { return loadingSubject.asObservable() }
    var selectedAppointment: Observable<Appointment> { return selectedAppointmentSubject.asObservable() }
    var sections: Observable<[(title: ReuseableCellViewModelType, rows: [ReuseableCellViewModelType])]> { return sectionsSubject.asObservable() }
    var isResident: Observable<Bool> { return isResidentSubject.asObservable() }
    var isRefreshing: Observable<Bool> { return isRefreshingSubject.asObservable() }
    var residentName: Observable<String> { return residentNameSubject.asObservable() }
    var residentImage: Observable<String> { return residentImageSubject.asObservable() }
    var residentRoom: Observable<String> { return residentRoomSubject.asObservable() }
    var isFilterApplied: Observable<Bool> { return isFilterAppliedSubject.asObservable() }
    var isAppointmentsFilterApplied: Observable<Bool> { return isAppointmentsFilterAppliedSubject.asObservable() }
    var facilityDataStoreOutput: FacilityDataStore { return self.facilityDataStore }
    var progress: Observable<Float> { return self.progressSubject }
    
    //Mark: Private Properties
    
    private let previousDateSubject = PublishSubject<Void>()
    private let nextDateSubject = PublishSubject<Void>()
    private let datePickerSubject = BehaviorSubject<Date>(value: Date())
    private let segmentControlSubject = PublishSubject<Int>()
    private let appointmentFilterSubject = PublishSubject<Void>()
    private let filterSubject = PublishSubject<Void>()
    private let selectAppointmentSubject = PublishSubject<Appointment>()
    private let markAppointmentSubject = PublishSubject<Appointment>()
    
    private let sortedAppointmentsSubject = BehaviorSubject<[Appointment]>(value: [])
    private let mappedAppointmentsSubject = BehaviorSubject<[Appointment]>(value: [])
    private let residentFilterAppointmentsSubject = BehaviorSubject<[Appointment]>(value: [])
    private let filteredAppointmentsSubject = BehaviorSubject<[Appointment]>(value: [])
    private let appointmentsSubject = BehaviorSubject<[Appointment]>(value: [])
    private let selectedAppointmentSubject = PublishSubject<Appointment>()
    private let lastUpdatedLabelSubject = BehaviorSubject<NSAttributedString?>(value: NSAttributedString(string: ""))
    private let dateNavigatorTitleSubject = BehaviorSubject<String?>(value: "")
    private let progressSubject = BehaviorSubject<Float>(value: 0.0)
    
    private let filterAppointmentsSubject = PublishSubject<Void>()
    private let refreshAppointmentsSubject = BehaviorSubject<Bool>(value: true)
    private let refreshingSubject = PublishSubject<Void>()
    private let refreshControlSubject = BehaviorSubject<Void>(value: Void())
    private let errorAlertSubject = PublishSubject<String>()
    private let sectionsSubject = BehaviorSubject<[(title: ReuseableCellViewModelType, rows: [ReuseableCellViewModelType])]>(value: [])
    private let loadingSubject = BehaviorSubject<Bool>(value: false)
    private let isResidentSubject = BehaviorSubject<Bool>(value: false)
    private let isRefreshingSubject = BehaviorSubject<Bool>(value: false)
    private let residentImageSubject = BehaviorSubject<String>(value: "")
    private let residentNameSubject = BehaviorSubject<String>(value: "")
    private let residentRoomSubject = BehaviorSubject<String> (value: "")
    private let isFilterAppliedSubject = BehaviorSubject<Bool>(value: false)
    let isAppointmentsFilterAppliedSubject = BehaviorSubject<Bool>(value: false)
    
    let disposeBag = DisposeBag()
    let facilityDataStore: FacilityDataStore
    let facilityId: Int
    let residentProvider: ResidentDataStore?
    let appointmentsRepository: AppointmentRepository
    let filterActionProvider: FilterActionProvider?
    let permissionProvider: PermissionProvider
    
    
    init(facilityDataStore: FacilityDataStore,
         appointmentsRepository: AppointmentRepository,
         filterActionProvider: FilterActionProvider?,
         permissionProvider: PermissionProvider){
        
        print("authorizedToManageAppointments: \(permissionProvider.authorizedToManageAppointments)")
        print("authorizedToViewTitleAppointments: \(permissionProvider.authorizedToViewTitleAppointments)")
        print("authorizedToViewTitleAndDescriptionAppointments: \(permissionProvider.authorizedToViewTitleAndDescriptionAppointments)")
        
        self.permissionProvider = permissionProvider
        self.facilityDataStore = facilityDataStore
        self.appointmentsRepository = appointmentsRepository
        self.filterActionProvider = filterActionProvider
        self.residentProvider = nil
        
        self.facilityId = facilityDataStore.currentFacility?["facility_id"] as? Int ?? 0
        self.datePickerSubject
            .map {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE, dd MMMM yyyy"
                return dateFormatter.string(from: $0)
            }
            .bind(to: dateNavigatorTitleSubject)
            .disposed(by: disposeBag)
        
        self.bindFetchAppointmentRequest()
        self.bindAppointmentsToCellViewModel()
        self.bindAppointmentsSorted()
        self.bindActions()
        
    }
    
    init(facilityDataStore: FacilityDataStore,
         appointmentsRepository: AppointmentRepository,
         residentProvider: ResidentDataStore?,
         filterActionProvider: FilterActionProvider?,
         permissionProvider: PermissionProvider){
        
        self.permissionProvider = permissionProvider
        self.facilityDataStore = facilityDataStore
        self.appointmentsRepository = appointmentsRepository
        self.filterActionProvider = filterActionProvider
        self.residentProvider = residentProvider
        self.facilityId = facilityDataStore.currentFacility?["facility_id"] as? Int ?? 0
        self.datePickerSubject
            .map {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE, dd MMMM yyyy"
                return dateFormatter.string(from: $0)
            }
            .bind(to: dateNavigatorTitleSubject)
            .disposed(by: disposeBag)
        
        self.bindFetchAppointmentRequest()
        self.bindAppointmentsToCellViewModel()
        self.bindAppointmentsSorted()
        self.bindActions()
        
    }
    
    func bindFetchAppointmentRequest() {
        
        
        let fetchRequest = Observable.combineLatest(self.refreshAppointmentsSubject, self.datePickerSubject)
            .flatMap { [weak self] refresh, date -> Observable<Event<([Appointment],Date?)>> in
                guard let self = self, let facilityID = self.facilityDataStore.currentFacility?["facility_id"] as? Int else { return .never() }
                if refresh {
                    self.loadingSubject.onNext(true)
                }
                self.isFilterAppliedSubject.onNext(self.filterActionProvider?.isFiltersApplied() ?? false)
                let residentId = self.residentProvider?.currentResident?["resident_id"] as? Int
                if residentId != nil {
                    return self.bindAppointmentsForResident(date: date, facilityID: facilityID, residentId: residentId!)
                }else {
                    return self.bindAppointmentsForTab(date: date, facilityID: facilityID)
                }
            }
            .share()
            .do(onNext: {
                appointment in
                self.loadingSubject.onNext(false)
                self.isRefreshingSubject.onNext(false)
            })
        
        fetchRequest.elements()
            .subscribe(onNext: {
                appointments,date in
                self.appointmentsSubject.onNext(appointments)
                let dateFormatterFromDate = DateFormatter()
                if date != nil {
                    dateFormatterFromDate.dateFormat = "MMMM dd'\(Date.getSuffixDate(date: date!))' 'at' h:mm a"
                    
                    let attributedString = NSMutableAttributedString(string: "Last Updated: \(dateFormatterFromDate.string(from: date!))", attributes: [
                        .font: UIFont.appFont(withStyle: .title3, size: 13),
                    ])
                    attributedString.addAttribute(.font, value: UIFont.appFont(withStyle: .title2, size: 13), range: NSRange(location: 0, length: 13))
                 
                    self.lastUpdatedLabelSubject.onNext(attributedString)
                } else {
                    self.lastUpdatedLabelSubject.onNext(NSAttributedString(string: ""))
                }
            })
            .disposed(by: disposeBag)
        
        fetchRequest.errors()
            .debug("Errors")
            .map {
                error in
                let error = error.asAFError(orFailWith: "The internet connection appears to be offline.")
                if error.isSessionTaskError {
                    return "The internet connection appears to be offline."
                } else {
                    return error.localizedDescription
                }
            }
            .bind(to: errorAlertSubject)
            .disposed(by: disposeBag)
        
        self.refreshingSubject.subscribe(onNext: {
            _ in
            self.refreshAppointmentsSubject.onNext(false)
        }).disposed(by: disposeBag)
        
        self.datePickerSubject.subscribe(onNext: {
            _ in
            self.refreshAppointmentsSubject.onNext(true)
        }).disposed(by: disposeBag)
        
        self.refreshControlSubject
            .subscribe(onNext: {
                refresh in
                self.isRefreshingSubject.onNext(true)
                self.refreshingSubject.onNext(Void())
            })
            .disposed(by: disposeBag)
        
    }
    
    func bindAppointmentsForTab(date: Date, facilityID: Int) -> Observable<Event<([Appointment],Date?)>>{
        self.isResidentSubject.onNext(false)
        return self.appointmentsRepository.getAppointments(for: facilityID,
                                                           date: date)
            .materialize()
    }
    
    func bindAppointmentsForResident(date: Date, facilityID: Int, residentId: Int) -> Observable<Event<([Appointment],Date?)>>{
        self.isResidentSubject.onNext(true)
        let residentName =  "\(self.residentProvider?.currentResident?["first_name"] as? String ?? "") \(self.residentProvider?.currentResident?["last_name"] as? String ?? "")"
        self.residentNameSubject.onNext(residentName)
        self.residentImageSubject.onNext(self.residentProvider?.currentResident?["profileImageRoute"] as? String ?? "")
        self.residentRoomSubject.onNext(self.residentProvider?.currentResident?["room_no"] as? String ?? "")
        return self.appointmentsRepository.getAppointmentsForResident(for: facilityID,
                                                                      residentID: residentId,
                                                                      date: date)
            .materialize()
    }
    
    func bindAppointmentsSorted(){
        
        self.appointmentsSubject.map{ appointments -> [Appointment] in
            var mappedAppointments = [Appointment]()
            for appointment in appointments {
                for appointmentAttendance in appointment.appointmentAttendance ?? [] {
                    mappedAppointments.append(Appointment(appointment: appointment, appointmentAttendance: appointmentAttendance))
                }
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
            
            mappedAppointments = mappedAppointments.sorted(by: {$0.appointmentAttendance?.first?.user?.fullName?.compare($1.appointmentAttendance?.first?.user?.fullName ?? "") == ComparisonResult.orderedAscending})
            
            if let residentId = self.residentProvider?.currentResident?["resident_id"] as? Int {
                let mappedAppointments = mappedAppointments.sorted(by: {dateFormatter.date(from: $0.startDate?.date ?? "")?.compare(dateFormatter.date(from: $1.startDate?.date ?? "") ?? Date()) == ComparisonResult.orderedAscending})
                return mappedAppointments.filter{
                    appointment in
                    return appointment.appointmentAttendance?.first?.residentId == residentId
                }
            } else {
                return mappedAppointments.sorted(by: {dateFormatter.date(from: $0.startDate?.date ?? "")?.compare(dateFormatter.date(from: $1.startDate?.date ?? "") ?? Date()) == ComparisonResult.orderedAscending})
            }
            
        }
        .bind(to: mappedAppointmentsSubject)
        .disposed(by: disposeBag)
        self.mappedAppointmentsSubject.map{ appointments -> [Appointment] in
            return self.filtersApply(appointments: appointments)
        }
        .bind(to: filteredAppointmentsSubject)
        .disposed(by: disposeBag)
        
        
        Observable.combineLatest(filteredAppointmentsSubject, segmentControlSubject)
            .map{ appointment , segment -> [Appointment] in
                
                let presentAppointments = appointment.filter{
                    $0.appointmentAttendance?.first?.present == "present"
                }
                
                let progress : Float
                
                if appointment.count > 0 {
                    if presentAppointments.count > 0 {
                        progress = 1.0 - (Float(appointment.count - presentAppointments.count ) / Float(appointment.count))
                    } else {
                        progress = 0.0
                    }
                } else {
                    progress = 0.0
                }
                
                self.progressSubject.onNext(progress)
                
                if segment == 0 {
                    return appointment
                }else{
                    return appointment.sorted(by: {($0.appointmentAttendance?.first?.user?.roomNo ?? "")?.compare($1.appointmentAttendance?.first?.user?.roomNo ?? "",options: [.numeric]) == ComparisonResult.orderedAscending})
                }
            }.bind(to: sortedAppointmentsSubject)
            .disposed(by: disposeBag)
        
    }
    
    func bindAppointmentsToCellViewModel() {
        
        self.sortedAppointmentsSubject
            .map { appointments -> [(title: ReuseableCellViewModelType, rows: [ReuseableCellViewModelType])] in
                return self.creatingSectionCellViewModel(appointments: appointments)
            }
            .bind(to: self.sectionsSubject)
            .disposed(by: disposeBag)
    }
    
    
    func creatingSectionCellViewModel(appointments: [Appointment] ) -> [(title: ReuseableCellViewModelType, rows: [ReuseableCellViewModelType])] {
        
        appointments.map { appointment -> (title: ReuseableCellViewModelType, rows: [ReuseableCellViewModelType]) in
            let cellViewModel = AppointmentTVCellViewModel(appointment: appointment, permissionProvider: permissionProvider)
            cellViewModel.outputs.markAppointment.subscribe(onNext: { appointment in
                self.appointmentsRepository.updateAppointment(appointment)
//                self.inputs.viewWillAppear.onNext(false)
            }).disposed(by: disposeBag)
            let headerTitle = HeaderTVCellViewModel(appointment: appointment, permissionProvider: permissionProvider)
            return (headerTitle, [cellViewModel])
        }
        
    }
}

extension AppointmentsViewModel {
    
    func bindActions() {
        
        nextDateSubject
            .withLatestFrom(self.datePickerSubject)
            .map { Calendar.current.date(byAdding: .day, value: 1, to: $0) }
            .unwrap()
            .bind(to: self.datePickerSubject)
            .disposed(by: disposeBag)
        
        previousDateSubject
            .withLatestFrom(self.datePickerSubject)
            .map { Calendar.current.date(byAdding: .day, value: -1, to: $0) }
            .unwrap()
            .bind(to: self.datePickerSubject)
            .disposed(by: disposeBag)
        
        segmentControlSubject
            .subscribe(onNext: { segmentIndex in
                print("Segment Tap \(segmentIndex)")
            })
            .disposed(by: disposeBag)
        
        filterSubject
            .subscribe(onNext: { _ in
                print("Filter Tap ")
                self.filterActionProvider?.filterButtonAction()
            })
            .disposed(by: disposeBag)
        
        appointmentFilterSubject
            .subscribe(onNext: { _ in
                print("Appointments Navigation Filter Tap ")
                self.filterAppointmentsSubject.onNext(Void())
            })
            .disposed(by: disposeBag)
        
        selectAppointmentSubject
            .bind(to: selectedAppointmentSubject)
            .disposed(by: disposeBag)
        
    }
}
