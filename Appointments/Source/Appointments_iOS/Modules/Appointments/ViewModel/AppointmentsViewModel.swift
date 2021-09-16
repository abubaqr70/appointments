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
    
}

protocol AppointmentsViewModelOutputs {
    
    //Sections
    var sections: Observable<[(title: String, rows: [ReuseableCellViewModelType])]> { get }
    
    // Actions:
    var lastUpdatedLabel: Observable<String?> { get }
    var dateNavigatorTitle: Observable<String?> { get }
    
    
}

protocol AppointmentsViewModelType {
    var inputs: AppointmentsViewModelInputs { get }
    var outputs: AppointmentsViewModelOutputs { get }
}

class AppointmentsViewModel: AppointmentsViewModelType, AppointmentsViewModelInputs, AppointmentsViewModelOutputs {
    
    var inputs: AppointmentsViewModelInputs { return self }
    var outputs: AppointmentsViewModelOutputs { return self }
    
    //Mark: Inputs
    var previousDateObserver: AnyObserver<Void> { return previousDateSubject.asObserver()}
    var nextDateObserver: AnyObserver<Void> { return nextDateSubject.asObserver()}
    var datePickerObserver: AnyObserver<Date> { return datePickerSubject.asObserver()}
    var segmentControlObserver: AnyObserver<Int> { return segmentControlSubject.asObserver()}
    var appointmentFilterObserver: AnyObserver<Void> { return appointmentFilterSubject.asObserver()}
    var filterObserver: AnyObserver<Void> { return filterSubject.asObserver()}
    
    //Mark: Outputs
    var lastUpdatedLabel: Observable<String?> { return  lastUpdatedLabelSubject.asObservable()}
    var dateNavigatorTitle: Observable<String?> { return  dateNavigatorTitleSubject.asObservable()}
    var sections: Observable<[(title: String, rows: [ReuseableCellViewModelType])]> { return sectionsSubject.asObservable() }
    
    //Mark: Private Properties
    
    private let previousDateSubject = PublishSubject<Void>()
    private let nextDateSubject = PublishSubject<Void>()
    private let datePickerSubject = BehaviorSubject<Date>(value: Date())
    private let segmentControlSubject = PublishSubject<Int>()
    private let appointmentFilterSubject = PublishSubject<Void>()
    private let filterSubject = PublishSubject<Void>()
    
    private let appointmentsSubject = BehaviorSubject<[Appointment]>(value: [])
    private let lastUpdatedLabelSubject = BehaviorSubject<String?>(value: "")
    private let dateNavigatorTitleSubject = BehaviorSubject<String?>(value: "")
    
    private let refreshAppointmentsSubject = PublishSubject<Void>()
    private let sectionsSubject = BehaviorSubject<[(title: String, rows: [ReuseableCellViewModelType])]>(value: [])
    
    private let disposeBag = DisposeBag()
    private let facilityIDSubject: BehaviorSubject<Int>
    private let appointmentsRepository: AppointmentRepository
    
    
    init(facilityID: Int,
         appointmentsRepository: AppointmentRepository){
        
        self.facilityIDSubject = BehaviorSubject(value: facilityID)
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
        self.bindActions()
        
    }
    
    func bindFetchAppointmentRequest() {
        
        let fetchRequest = self.refreshAppointmentsSubject
            .withLatestFrom(Observable.combineLatest(self.facilityIDSubject, self.datePickerSubject))
            .flatMap { [weak self] facilityID, date -> Observable<Event<[Appointment]>> in
                
                guard let self = self else { return .never() }
                
                let startDate = Calendar.current.startOfDay(for: date)
                var components = DateComponents()
                components.day = 1
                components.second = -1
                let endDate = Calendar.current.date(byAdding: components, to: startDate)!
                
                return self.appointmentsRepository.getAppointments(for: facilityID,
                                                                   startDate: startDate.timeIntervalSince1970,
                                                                   endDate: endDate.timeIntervalSince1970)
                    .materialize()
            }
            .share()
        
        fetchRequest.elements()
            .map({
                appointments -> [Appointment] in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
                return appointments.sorted(by: {dateFormatter.date(from: $0.start_date?.m ?? "")?.compare(dateFormatter.date(from: $1.start_date?.m ?? "") ?? Date()) == ComparisonResult.orderedDescending})
            })
            .bind(to: appointmentsSubject.asObserver())
            .disposed(by: disposeBag)
        
        appointmentsSubject
            .map { appointments -> [(title: String, rows: [ReuseableCellViewModelType])] in
                appointments.map { appointment -> (title: String, rows: [ReuseableCellViewModelType]) in
                    let cellViewModel = AppointmentTVCellViewModel(appointment: appointment)
                    let headerTitle = "\(appointment.start_date?.time ?? "") - \(appointment.end_date?.time ?? "")"
                    return (headerTitle, [cellViewModel])
                }
            }
            .bind(to: self.sectionsSubject)
            .disposed(by: disposeBag)
        
        fetchRequest.errors()
            .debug("Errors")
            .subscribe()
            .disposed(by: disposeBag)
        
        self.datePickerSubject
            .map { _ in () }
            .bind(to: self.refreshAppointmentsSubject)
            .disposed(by: disposeBag)
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
            })
            .disposed(by: disposeBag)
    }
}

