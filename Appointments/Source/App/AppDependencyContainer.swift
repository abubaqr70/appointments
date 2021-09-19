// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

public class AppDependencyContainer {
    
    private let baseURL: String
    private let authentication: AuthenticationConvertible
    private let userDataStore: UserDataStore
    private let facilityDataStore: FacilityDataStore
    private let addActionProvider: AddActionProvider?
    private let filterActionProvider: FilterActionProvider?
    private let client: APIClient
    
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
        self.client = AlamofireClient()
    }
    
    
    public func makeAppointmentsCoordinator(root: UIViewController,
                                            navigationType: NavigationType) -> AppCoordinator {
        
        return AppCoordinator(root: root,
                              navigationType: navigationType,
                              factory: self)
    }
    
    func makeAppointmentsViewController(viewModel: AppointmentsViewModelType) -> AppointmentsViewController {
        
        return AppointmentsViewController(viewModel: viewModel)
    }
    
    func makeAppointmentsViewModel() -> AppointmentsViewModelType {
        
        let service = AppointmentService(baseURL: self.baseURL,
                                         authHeaderProvider: self.authentication,
                                         client: self.client)
        
        let repository = AppointmentRepository(appointmentService: service)
        
        let facilityID = self.facilityDataStore.currentFacility?["id"] as? Int ?? 0
        
        return AppointmentsViewModel(facilityID: facilityID,
                                     appointmentsRepository: repository )
    }
    
}
