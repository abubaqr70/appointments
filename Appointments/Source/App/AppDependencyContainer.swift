// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

public class AppDependencyContainer {
    
    private let baseURL: String
    private let authentication: AuthenticationConvertible
    private let userDataStore: UserDataStore
    private let facilityDataStore: FacilityDataStore
    private let addActionProvider: AddActionProvider?
    private let filterActionProvider: FilterActionProvider?
    
    public init(baseURL: String,
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
        
        print(self.baseURL)
        print(self.authentication.authenticationHeader)
        print(self.userDataStore.currentUser)
        print(self.facilityDataStore.currentFacility)
    }
    
    
    public func makeAppointmentsCoordinator(root: UIViewController) -> AppCoordinator {
        return AppCoordinator(root: root,
                              factory: self)
        
    }
    
    func makeAppointmentsViewController(viewModel: AppointmentsViewModelType) -> AppointmentsViewController {
        return AppointmentsViewController()
    }
    
    func makeAppointmentsViewModel() -> AppointmentsViewModelType {
        return AppointmentsViewModel()
    }
}
