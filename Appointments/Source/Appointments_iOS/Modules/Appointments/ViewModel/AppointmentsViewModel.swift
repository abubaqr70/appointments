// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxSwift

protocol AppointmentsViewModelInputs {
    
    // Actions:
    var previousDateObserver: AnyObserver<Void> { get }
    var nextDateObserver: AnyObserver<Void> { get }
    var datePickerObserver: AnyObserver<Date?> { get }
    var segmentControlObserver: AnyObserver<Int> { get }
    var appointmentFilterObserver: AnyObserver<Void> { get }
    var filterObserver: AnyObserver<Void> { get }
    
}

protocol AppointmentsViewModelOutputs {
    
    //Appointments
    var appointments: Observable<[Appointment]?> { get }
    
    // Actions:
    var lastUpdatedLabel: Observable<String?> { get }
    var dateNavigatorTitle: Observable<Date?> { get }
    
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
    var datePickerObserver: AnyObserver<Date?> { return datePickerSubject.asObserver()}
    var segmentControlObserver: AnyObserver<Int> { return segmentControlSubject.asObserver()}
    var appointmentFilterObserver: AnyObserver<Void> { return appointmentFilterSubject.asObserver()}
    var filterObserver: AnyObserver<Void> { return filterSubject.asObserver()}
    
    //Mark: Outputs
    var appointments: Observable<[Appointment]?> { return  appointmentsSubject.asObservable()}
    var lastUpdatedLabel: Observable<String?> { return  lastUpdatedLabelSubject.asObservable()}
    var dateNavigatorTitle: Observable<Date?> { return  dateNavigatorTitleSubject.asObservable()}
    
    //Mark: Private Properties
    
    private let previousDateSubject = PublishSubject<Void>()
    private let nextDateSubject = PublishSubject<Void>()
    private let datePickerSubject = BehaviorSubject<Date?>(value: Date())
    private let segmentControlSubject = PublishSubject<Int>()
    private let appointmentFilterSubject = PublishSubject<Void>()
    private let filterSubject = PublishSubject<Void>()
    
    private let appointmentsSubject = BehaviorSubject<[Appointment]?>(value: [])
    private let lastUpdatedLabelSubject = BehaviorSubject<String?>(value: "")
    private let dateNavigatorTitleSubject = BehaviorSubject<Date?>(value: Date())
    
    private let disposeBag = DisposeBag()
    
    init(){
        
        datePickerSubject.asObserver()
            .bind(to: dateNavigatorTitleSubject)
            .disposed(by: disposeBag)
        
        bindActions()
    }

}

extension AppointmentsViewModel {
    
    func bindActions(){
        nextDateSubject.asObserver()
            .subscribe(onNext: { [weak self] in
                guard let self = self else {return}
                print("next Tap")
                self.datePickerSubject.on(.next(self.convertToNextDate(date: try! self.datePickerSubject.value() ?? Date())))
            })
            .disposed(by: disposeBag)
        
        previousDateSubject.asObserver()
            .subscribe(onNext: { [weak self] in
                guard let self = self else {return}
                print("previous Tap")
                self.datePickerSubject.on(.next(self.convertPreviousDate(date: try! self.datePickerSubject.value() ?? Date())))
            })
            .disposed(by: disposeBag)
        
        segmentControlSubject.asObserver()
            .subscribe(onNext: { segmentIndex in
                print("Segment Tap \(segmentIndex)")
            })
            .disposed(by: disposeBag)
        
        filterSubject.asObserver()
            .subscribe(onNext: { _ in
                print("Filter Tap ")
            })
            .disposed(by: disposeBag)
        
        appointmentFilterSubject.asObserver()
            .subscribe(onNext: { _ in
                print("Appointments Navigation Filter Tap ")
            })
            .disposed(by: disposeBag)
    }
}

extension AppointmentsViewModel {
    func convertToNextDate(date:Date) -> Date {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? Date()
        return tomorrow
    }
    
    func convertPreviousDate(date:Date) -> Date {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? Date()
        return yesterday
    }
}
