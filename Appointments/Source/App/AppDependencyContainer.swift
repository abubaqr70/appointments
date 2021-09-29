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
    private let repository: AppointmentRepository
    
    
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
        
        let service = AppointmentService(baseURL: self.baseURL,
                                         authHeaderProvider: self.authentication,
                                         client: self.client)
        let coreDataStore = AppointmentsCoreDataStore(coreDataStack: CoreDataStack())
        self.repository = AppointmentRepository(appointmentService: service,coreDataStore: coreDataStore)
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
    
    func makeAppointmentDetailViewController(viewModel: AppointmentDetailViewModelType) -> AppointmentDetailViewController {
        
        return AppointmentDetailViewController(viewModel: viewModel)
    }
    
    func makeAppointmentsViewModel() -> AppointmentsViewModelType {
        
        return AppointmentsViewModel(facilityDataStore: self.facilityDataStore,
                                     appointmentsRepository: self.repository)
    }
    
    func makeAppointmentDetailViewModel(appointment: Appointment) -> AppointmentDetailViewModelType {
        
        return AppointmentDetailViewModel(appointment: appointment, repository: self.repository)
    }
    
}
