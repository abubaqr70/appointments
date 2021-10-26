// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxCocoa
import RxSwift

protocol FilterHeaderTVCellViewModelInputs {
    
    //TODO :- Inputs here
    var markCheckbox : AnyObserver<Void> { get }
}

protocol FilterHeaderTVCellViewModelOutputs {
    
    // Actions:
    var headerTitle: Observable<String?> { get }
    var checkFilter : Observable<Bool> { get }
    var headerType: Observable<String> { get }

}

protocol FilterHeaderTVCellViewModelType {
    var inputs: FilterHeaderTVCellViewModelInputs { get }
    var outputs: FilterHeaderTVCellViewModelOutputs { get }
}

class FilterHeaderTVCellViewModel: FilterHeaderTVCellViewModelType, FilterHeaderTVCellViewModelInputs, FilterHeaderTVCellViewModelOutputs,ReuseableCellViewModelType {
    
    var reuseIdentifier: String = FilterHeaderTableViewCell.reuseIdentifier
    
    var inputs: FilterHeaderTVCellViewModelInputs { return self }
    var outputs: FilterHeaderTVCellViewModelOutputs { return self }
    
    //Mark: Inputs
    var markCheckbox: AnyObserver<Void> { return markCheckboxSubject.asObserver() }
    
    //Mark: Outputs
    var headerTitle: Observable<String?> { return headerTitleSubject.asObservable() }
    var checkFilter: Observable<Bool> { return checkFilterSubject.asObservable() }
    var headerType: Observable<String> { return headerTypeSubject.asObservable() }
  
    //Mark: Init
    private let disposeBag = DisposeBag()
    private let headerTitleSubject: BehaviorSubject<String?>
    private let markCheckboxSubject : PublishSubject<Void>
    private let checkFilterSubject : BehaviorSubject<Bool>
    private let headerTypeSubject : PublishSubject<String>
  
    init(headerTitle: String, isSelectedAll: Bool) {
        
        //Mark:- Setting Properties
        self.headerTitleSubject = BehaviorSubject(value: headerTitle)
        self.markCheckboxSubject = PublishSubject()
        self.checkFilterSubject = BehaviorSubject(value: false)
        self.headerTypeSubject = PublishSubject()
        self.bindActions(headerTitle: headerTitle, isSelectedAll: isSelectedAll)
    }
    
}

extension FilterHeaderTVCellViewModel {
    
    func bindActions(headerTitle: String, isSelectedAll: Bool) {
        
        checkFilterSubject.onNext( isSelectedAll ? true : false )
        
        
        markCheckboxSubject
            .withLatestFrom(self.checkFilterSubject)
            .map { isPresent -> Bool in
                return !isPresent
            }
            .unwrap()
            .subscribe(onNext: {
                present in
                self.checkFilterSubject.onNext(present)
                self.headerTypeSubject.onNext(headerTitle)
            })
            .disposed(by: disposeBag)
        
    }
    
}


