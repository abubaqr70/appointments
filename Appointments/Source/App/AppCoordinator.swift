// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxSwift

public class AppCoordinator: Coordinator<ResultType<Void>> {
    
    private let result = PublishSubject<ResultType<Void>>()
    private let root: UIViewController
    private let factory: AppointmentsFactory
    
    init(root: UIViewController,
         factory: AppointmentsFactory) {
        self.root = root
        self.factory = factory
    }
    
    public override func start() -> Observable<ResultType<Void>> {
        let apiclient = self.factory.makeApiClient()
        let authHeader = self.factory.makeAuthHeader()
        let pathVariables = self.factory.makePathVariables()
        let appointmentsService = self.factory.makeAppointmentsService(authHeader: authHeader, apiClient: apiclient,pathVariables: pathVariables)
        let appointmentsRepository = self.factory.makeAppointmentsRepository(appintmentService: appointmentsService)
        let viewModel = self.factory.makeAppointmentsViewModel(appointmentRepositry: appointmentsRepository)
        let viewController = self.factory.makeAppointmentsViewController(viewModel: viewModel)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        self.root.present(navigationController, animated: true)
        
        return result
    }
}


protocol AppointmentsFactory {
    func makeAuthHeader() -> AuthHeaderProvider
    func makeApiClient() -> APIClient
    func makePathVariables() -> [String]
    func makeAppointmentsService(authHeader: AuthHeaderProvider, apiClient : APIClient, pathVariables :[String]) -> AppointmentService
    func makeAppointmentsRepository(appintmentService : AppointmentService) -> AppointmentRepository
    func makeAppointmentsViewController(viewModel: AppointmentsViewModelType) -> AppointmentsViewController
    func makeAppointmentsViewModel(appointmentRepositry: AppointmentRepository) -> AppointmentsViewModelType
}

extension AppDependencyContainer: AppointmentsFactory {

}
