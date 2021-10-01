// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

public protocol DataHandler {
    
    func clearData()
    func syncData()
    
}

class AppointmentDataHandler : DataHandler{
    
    let repository : AppointmentRepository
    
    init(repository: AppointmentRepository){
        self.repository = repository
    }
    
    func clearData() {
        self.repository.clearData()
    }
    
    func syncData() {
        self.repository.syncData()
    }
}
