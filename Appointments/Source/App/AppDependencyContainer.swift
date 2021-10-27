// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

@objc public class AppDependencyContainer : NSObject {
    
    private let baseURL: String
    private let authentication: AuthenticationConvertible
    private let userDataStore: UserDataStore
    private let facilityDataStore: FacilityDataStore
    private let client: APIClient
    private let repository: AppointmentRepository
    private let dataHandler: AppointmentDataHandler
    
    public init(baseURL: String,
                authentication: AuthenticationConvertible,
                userDataStore: UserDataStore,
                facilityDataStore: FacilityDataStore) {
        
        self.baseURL = baseURL
        self.authentication = authentication
        self.userDataStore = userDataStore
        self.facilityDataStore = facilityDataStore
        self.client = AlamofireClient()
        let service = AppointmentService(baseURL: self.baseURL,
                                         authHeaderProvider: self.authentication,
                                         client: self.client)
        let appointmentDataStore = AppointmentsCoreDataStore(coreDataStack: CoreDataStack())
        let facilityStaffDataStore = FacilityStaffCoreDataStore(coreDataStack: CoreDataStack())
        let appointmentsTypeDataStore = AppointmentsTypeCoreDataStore(coreDataStack: CoreDataStack())
        let lastUpdatedDataStore = LastUpdatedCoreDataStore(coreDataStack: CoreDataStack())
        self.repository = AppointmentRepository(appointmentService: service, appointmentDataStore: appointmentDataStore, facilityStaffDataStore: facilityStaffDataStore, appointmentsTypeDataStore: appointmentsTypeDataStore, lastUpdatedDataStore: lastUpdatedDataStore, facilityDataStore: facilityDataStore)
        self.dataHandler = AppointmentDataHandler(repository: self.repository)
    }
    
    
    public func makeAppointmentsCoordinator(root: UIViewController,
                                            navigationType: NavigationType,
                                            addActionProvider: AddActionProvider?,
                                            filterActionProvider: FilterActionProvider?,
                                            residentProvider: ResidentDataStore?) -> AppCoordinator {
        
        return AppCoordinator(root: root,
                              navigationType: navigationType,
                              factory: self,
                              addActionProvider: addActionProvider,
                              filterActionProvider: filterActionProvider,
                              residentProvider: residentProvider)
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
    
    func makeFilterAppointmentsViewController(viewModel: FilterAppointmentsViewModelType) -> FilterAppointmentsViewController {
        
        return FilterAppointmentsViewController(viewModel: viewModel)
    }
    
    func makeAppointmentsViewModel(residentProvider: ResidentDataStore?,filterActionProvider: FilterActionProvider?) -> AppointmentsViewModelType {
        if residentProvider != nil {
            return AppointmentsViewModel(facilityDataStore: self.facilityDataStore,
                                         appointmentsRepository: self.repository,
                                         residentProvider: residentProvider,
                                         filterActionProvider: filterActionProvider)
        }  else {
            return AppointmentsViewModel(facilityDataStore: self.facilityDataStore,
                                         appointmentsRepository: self.repository,
                                         filterActionProvider: filterActionProvider)
        }
        
    }
    
    func makeAppointmentViewModel(appointment: Appointment) -> AppointmentViewModelType {
        
        return AppointmentViewModel(appointment: appointment, repository: self.repository)
    }
    
    func makeFilterAppointmentsViewModel() -> FilterAppointmentsViewModelType {
        
        return FilterAppointmentsViewModel(appointmentsRepository: self.repository,
                                           facilityDataStore: self.facilityDataStore)
    }
    
}
