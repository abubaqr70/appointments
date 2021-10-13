// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

@objc public class AppDependencyContainer : NSObject {
    
    private let baseURL: String
    private let authentication: AuthenticationConvertible
    private let userDataStore: UserDataStore
    private let facilityDataStore: FacilityDataStore
    private let addActionProvider: AddActionProvider?
    private let filterActionProvider: FilterActionProvider?
    private let client: APIClient
    private let repository: AppointmentRepository
    private let dataHandler: AppointmentDataHandler
    
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
        let dataStore = AppointmentsCoreDataStore(coreDataStack: CoreDataStack())
        self.repository = AppointmentRepository(appointmentService: service,dataStore: dataStore,facilityDataStore: self.facilityDataStore)
        self.dataHandler = AppointmentDataHandler(repository: self.repository)
    }
    
    public func makeAppointmentsCoordinator(root: UIViewController,
                                            navigationType: NavigationType) -> AppCoordinator {
        
        return AppCoordinator(root: root,
                              navigationType: navigationType,
                              factory: self)
    }
    
    
    @objc public func clearData() {
        self.dataHandler.clearData()
    }
    
    @objc public func setIsSyncingStarted() {
        self.dataHandler.setIsSyncing(isSyncing: true)
    }
    
    @objc public func setIsSyncingDone() {
        self.dataHandler.setIsSyncing(isSyncing: false)
    }
    
    @objc public func getIsSyncing() -> Bool {
        return self.dataHandler.getIsSyncing()
    }
    
    @objc public func syncData(completion : @escaping (Bool,Error?) -> Void){
        self.dataHandler.syncData() {
            result in
            switch result {
            case .success():
                completion(true, nil)
                print("Data Synced Successfully")
            case .failure(let error):
                completion(false, error)
                print(error.localizedDescription)
            }
        }
    }
    
    func makeAppointmentsViewController(viewModel: AppointmentsViewModelType) -> AppointmentsViewController {
        
        return AppointmentsViewController(viewModel: viewModel)
    }
    
    func makeAppointmentViewController(viewModel: AppointmentViewModelType) -> AppointmentViewController {
        
        return AppointmentViewController(viewModel: viewModel)
    }
    
    func makeAppointmentsViewModel() -> AppointmentsViewModelType {
        
        return AppointmentsViewModel(facilityDataStore: self.facilityDataStore,
                                     appointmentsRepository: self.repository)
    }
    
    func makeAppointmentViewModel(appointment: Appointment) -> AppointmentViewModelType {
        
        return AppointmentViewModel(appointment: appointment, repository: self.repository)
    }
    
}
