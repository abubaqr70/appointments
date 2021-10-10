// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

public protocol DataHandler {
    
    func clearData()
    func syncData(completion : @escaping (Result<Void,Error>) -> Void)
    
}

class AppointmentDataHandler : DataHandler{
    
    let repository : AppointmentRepository
    
    init(repository: AppointmentRepository){
        self.repository = repository
    }
    
    func clearData() {
        self.repository.clearAllData()
    }
    
    func syncData(completion : @escaping (Result<Void,Error>) -> Void) {
        self.repository.syncData(completion: completion)
    }
}
