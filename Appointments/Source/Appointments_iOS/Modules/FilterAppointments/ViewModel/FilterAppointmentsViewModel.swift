// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxCocoa
import RxSwift

protocol FilterAppointmentsViewModelInputs {
    
    // Actions:
   
}

protocol FilterAppointmentsViewModelOutputs {
    
    //Sections
  
}

protocol FilterAppointmentsViewModelType {
    var inputs: FilterAppointmentsViewModelInputs { get }
    var outputs: FilterAppointmentsViewModelOutputs { get }
}

class FilterAppointmentsViewModel : FilterAppointmentsViewModelType, FilterAppointmentsViewModelInputs, FilterAppointmentsViewModelOutputs {
  
    var inputs: FilterAppointmentsViewModelInputs { return self }
    var outputs: FilterAppointmentsViewModelOutputs { return self }
    
    init(appointmentsRepository: AppointmentRepository) {
        
    }
    
}
