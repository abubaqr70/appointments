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
        
    }
    
    
    public func makeAppointmentsCoordinator(root: UIViewController) -> AppCoordinator {
        return AppCoordinator(root: root,
                              factory: self)
        
    }
    
    func makeAuthHeader() -> AuthHeaderProvider {
        return AuthHeader(headers: authentication.authenticationHeader)
    }
    
    func makeApiClient() -> APIClient {
        return AlamofireClient()
    }
    
    func makePathVariables() -> [String] {
        if let facilityId = self.facilityDataStore.currentFacility?["id"] {
            return ["facilities","\(facilityId as! Int)"]
        }
        return ["facilities"]
    }
    
    func makeAppointmentsService(authHeader: AuthHeaderProvider, apiClient : APIClient, pathVariables :[String]) -> AppointmentService {
        return AppointmentService(baseURL: baseURL, authHeaderProvider: authHeader, client: apiClient, pathVariables: pathVariables)
    }
    
    func makeAppointmentsRepository(appintmentService : AppointmentService) -> AppointmentRepository {
        return AppointmentRepository(appointmentService: appintmentService)
    }
    
    func makeAppointmentsViewController(viewModel: AppointmentsViewModelType) -> AppointmentsViewController {
        return AppointmentsViewController(viewModel: viewModel)
    }
    
    func makeAppointmentsViewModel(appointmentRepositry : AppointmentRepository) -> AppointmentsViewModelType {
        return AppointmentsViewModel(appointmentsRepository: appointmentRepositry)
    }
    
}
