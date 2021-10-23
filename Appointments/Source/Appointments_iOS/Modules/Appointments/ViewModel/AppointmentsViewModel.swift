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
    var viewWillAppear: AnyObserver<Void> { get }
    var refreshControl: AnyObserver<Void> { get }
    
}

protocol AppointmentsViewModelOutputs {
    
    //Sections
    var sections: Observable<[(title: String, rows: [ReuseableCellViewModelType])]> { get }
    var selectedAppointment: Observable<Appointment> { get }
    
    // Actions:
    var lastUpdatedLabel: Observable<String?> { get }
    var dateNavigatorTitle: Observable<String?> { get }
    var errorAlert: Observable<String> { get }
    var isLoading: Observable<Bool> { get }
    var filterAppointments: Observable<Void> { get }
    var isRefreshing: Observable<Bool> { get }
    var isResident: Observable<Bool> { get }
    var residentName: Observable<String> { get }
    var residentImage: Observable<String> { get }
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
    var viewWillAppear: AnyObserver<Void> { return refreshAppointmentsSubject.asObserver() }
    var refreshControl: AnyObserver<Void> { return refreshControlSubject.asObserver() }
    
    //Mark: Outputs
    var lastUpdatedLabel: Observable<String?> { return  lastUpdatedLabelSubject.asObservable() }
    var dateNavigatorTitle: Observable<String?> { return  dateNavigatorTitleSubject.asObservable() }
    var filterAppointments: Observable<Void> { return filterAppointmentsSubject.asObservable() }
    var errorAlert: Observable<String> { return errorAlertSubject.asObservable() }
    var isLoading: Observable<Bool> { return loadingSubject.asObservable() }
    var selectedAppointment: Observable<Appointment> { return selectedAppointmentSubject.asObservable() }
    var filterAppointments: Observable<Void> { return filterAppointmentsSubject.asObservable() }
    var isResident: Observable<Bool> { return isResidentSubject.asObservable() }
    var isRefreshing: Observable<Bool> { return isRefreshingSubject.asObservable() }
    var residentName: Observable<String> { return residentNameSubject.asObservable() }
    var residentImage: Observable<String> { return residentImageSubject.asObservable() }
    
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
    private let appointmentsSubject = BehaviorSubject<[Appointment]>(value: [])
    private let selectedAppointmentSubject = PublishSubject<Appointment>()
    private let lastUpdatedLabelSubject = BehaviorSubject<String?>(value: "")
    private let dateNavigatorTitleSubject = BehaviorSubject<String?>(value: "")
    
    private let filterAppointmentsSubject = PublishSubject<Void>()
    private let refreshAppointmentsSubject = PublishSubject<Void>()
    private let refreshingSubject = PublishSubject<Void>()
    private let refreshControlSubject = BehaviorSubject<Void>(value: Void())
    private let errorAlertSubject = PublishSubject<String>()
    private let sectionsSubject = BehaviorSubject<[(title: String, rows: [ReuseableCellViewModelType])]>(value: [])
    private let loadingSubject = BehaviorSubject<Bool>(value: false)
    private let isResidentSubject = BehaviorSubject<Bool>(value: false)
    private let isRefreshingSubject = BehaviorSubject<Bool>(value: false)
    private let residentImageSubject = BehaviorSubject<String>(value: "")
    private let residentNameSubject = BehaviorSubject<String>(value: "")
    
    private let disposeBag = DisposeBag()
    private let facilityDataStore: FacilityDataStore
    private let residentProvider: ResidentDataStore?
    private let appointmentsRepository: AppointmentRepository
    
    
    init(facilityDataStore: FacilityDataStore,
         appointmentsRepository: AppointmentRepository){
        
        self.facilityDataStore = facilityDataStore
        self.appointmentsRepository = appointmentsRepository
        self.residentProvider = nil
        self.datePickerSubject
            .map {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE, MMM dd, yyyy"
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
         residentProvider: ResidentDataStore?){
        
        self.residentProvider = residentProvider
        self.facilityDataStore = facilityDataStore
        self.appointmentsRepository = appointmentsRepository
        
        self.datePickerSubject
            .map {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE, MMM dd, yyyy"
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
        
        
        let fetchRequest = self.refreshAppointmentsSubject
            .withLatestFrom(self.datePickerSubject)
            .flatMap { [weak self] date -> Observable<Event<([Appointment],Date?)>> in
                guard let self = self, let facilityID = self.facilityDataStore.currentFacility?["facility_id"] as? Int else { return .never() }
                self.loadingSubject.onNext(true)
                let residentId = self.residentProvider?.currentResident?["resident_id"] as? Int
                if residentId != nil {
                    self.isResidentSubject.onNext(true)
                    let residentName =  "\(self.residentProvider?.currentResident?["first_name"] as? String ?? "") \(self.residentProvider?.currentResident?["last_name"] as? String ?? "")"
                    self.residentNameSubject.onNext(residentName)
                    self.residentImageSubject.onNext(self.residentProvider?.currentResident?["profileImageRoute"] as? String ?? "")
                    return self.appointmentsRepository.getAppointmentsForResident(for: facilityID,
                                                                                  residentID: residentId!,
                                                                                  date: date)
                        .materialize()
                }else {
                    self.isResidentSubject.onNext(false)
                    return self.appointmentsRepository.getAppointments(for: facilityID,
                                                                       date: date)
                        .materialize()
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
                    self.lastUpdatedLabelSubject.onNext("Last Updated: " + dateFormatterFromDate.string(from: date!))
                } else {
                    self.lastUpdatedLabelSubject.onNext("")
                }
            })
            .disposed(by: disposeBag)
        
        fetchRequest.errors()
            .debug("Errors")
            .map{$0.localizedDescription}
            .bind(to: errorAlertSubject)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(self.refreshingSubject, self.datePickerSubject)
            .map { _ in () }
            .bind(to: self.refreshAppointmentsSubject)
            .disposed(by: disposeBag)
        
        self.refreshControlSubject
            .subscribe(onNext: {
                refresh in
                self.isRefreshingSubject.onNext(true)
                self.refreshingSubject.onNext(Void())
            })
            .disposed(by: disposeBag)
        
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
            return mappedAppointments.sorted(by: {dateFormatter.date(from: $0.startDate?.date ?? "")?.compare(dateFormatter.date(from: $1.startDate?.date ?? "") ?? Date()) == ComparisonResult.orderedAscending})
        }
        .bind(to: mappedAppointmentsSubject)
        .disposed(by: disposeBag)
        
        Observable.combineLatest(mappedAppointmentsSubject, segmentControlSubject)
            .map{ appointment , segment -> [Appointment] in
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
            .map { appointments -> [(title: String, rows: [ReuseableCellViewModelType])] in
                return self.creatingSectionCellViewModel(appointments: appointments)
            }
            .bind(to: self.sectionsSubject)
            .disposed(by: disposeBag)
    }
    
    
    func creatingSectionCellViewModel(appointments: [Appointment] ) -> [(title: String, rows: [ReuseableCellViewModelType])] {
        
        appointments.map { appointment -> (title: String, rows: [ReuseableCellViewModelType]) in
            let cellViewModel = AppointmentTVCellViewModel(appointment: appointment)
            cellViewModel.outputs.markAppointment.subscribe(onNext: { appointment in
                self.appointmentsRepository.updateAppointment(appointment)
                self.inputs.viewWillAppear.onNext(Void())
            }).disposed(by: disposeBag)
            let headerTitle = "\(appointment.startDate?.timeString ?? "") - \(appointment.endDate?.timeString ?? "")"
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

