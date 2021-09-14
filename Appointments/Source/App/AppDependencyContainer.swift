// Copyright © 2021 Caremerge. All rights reserved.

import Foundation


class AppDependencyContainer {
    
    private let baseURL: String
    private let authentication: AuthenticationConvertible
    private let userDataStore: UserDataStore
    private let facilityDataStore: FacilityDataStore
    private let addActionProvider: AddActionProvider?
    private let filterActionProvider: FilterActionProvider?
    
    init(baseURL: String,
         authentication: AuthenticationConvertible,
         userDataStore: UserDataStore,
         facilityDataStore: FacilityDataStore,
         addActionProvider: AddActionProvider?,
         filterActionProvider: FilterActionProvider?) {
        
        self.baseURL = baseURL
        self.authentication = authentication
        self.userDataStore = userDataStore
        self.facilityDataStore = facilityDataStore
        self.addActionProvider = addActionProvider
        self.filterActionProvider = filterActionProvider
    }
    
}
