// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxSwift

protocol AppointmentsViewModelInputs {
    
}

protocol AppointmentsViewModelOutputs {
    
}

protocol AppointmentsViewModelType {
    var inputs: AppointmentsViewModelInputs { get }
    var outputs: AppointmentsViewModelOutputs { get }
}

class AppointmentsViewModel: AppointmentsViewModelType, AppointmentsViewModelInputs, AppointmentsViewModelOutputs {
    
    var inputs: AppointmentsViewModelInputs { return self }
    var outputs: AppointmentsViewModelOutputs { return self }
    
    //MARK: Inputs
    
    
    //MARK: Outputs
    
    
    
    private let disposeBag = DisposeBag()
    
    init() {
        
    }
}

extension AppointmentsViewModel {
    
}
