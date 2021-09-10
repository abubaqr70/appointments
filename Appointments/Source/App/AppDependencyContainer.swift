// Copyright © 2021 Caremerge. All rights reserved.

import Foundation


public protocol SessionDataStore {
    func readUserSession() -> String
}

class AppDependencyContainer {
    
    private let baseURL: String
    private let sessionDataStore: SessionDataStore
    
    init(baseURL: String,
         sessionDataStore: SessionDataStore) {
        
        self.baseURL = baseURL
        self.sessionDataStore = sessionDataStore
    }
    
}
