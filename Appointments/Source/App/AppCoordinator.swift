// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxSwift


public enum NavigationType {
    case push
    case present
    case append
}

extension NavigationType {
    
    public func navigate(to viewController: UIViewController,
                         root: UIViewController) {
        
        switch self {
        case .push:
            if let root = root as? UINavigationController {
                root.pushViewController(viewController, animated: true)
            } else {
                fatalError("Pushing viewController on non navigation controller")
            }
        case .present:
            root.present(viewController, animated: true)
        case .append:
            if let tabBarController = root as? UITabBarController {
                var viewControllers = tabBarController.viewControllers
                if viewControllers == nil { viewControllers = [] }
                viewControllers?.append(viewController)
                tabBarController.viewControllers = viewControllers
            }
        }
    }
}

public class AppCoordinator: Coordinator<ResultType<Void>> {
    
    private let result = PublishSubject<ResultType<Void>>()
    private let root: UIViewController
    private let navigationType: NavigationType
    private let factory: AppointmentsFactory
    private var rootNavigationController: UINavigationController?
  
    init(root: UIViewController,
         navigationType: NavigationType,
         factory: AppointmentsFactory) {
        self.root = root
        self.navigationType = navigationType
        self.factory = factory

    }
    
    public override func start() -> Observable<ResultType<Void>> {
        let viewModel = self.factory.makeAppointmentsViewModel()
        let viewController = self.factory.makeAppointmentsViewController(viewModel: viewModel)
    
        self.bindAppointmentViewModel(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.rootNavigationController = navigationController
    
        self.navigationType.navigate(to: navigationController, root: self.root)
        
        return result
    }
    
    func bindAppointmentViewModel(viewModel : AppointmentsViewModelType) {
        viewModel.outputs.selectedAppointment.subscribe({ appointment in
            guard let appointment = appointment.element else {return}
            self.navigateToDetail(appointment: appointment)
        }).disposed(by: disposeBag)
    
        viewModel.outputs.filterAppointments.subscribe(onNext: {
            self.presentFilterAppointments()
        }).disposed(by: disposeBag)
    }
    
    func navigateToDetail(appointment: Appointment) {
        let viewModel = self.factory.makeAppointmentViewModel(appointment: appointment)
        let viewController = self.factory.makeAppointmentViewController(viewModel: viewModel)
        self.rootNavigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentFilterAppointments() {
        let viewModel = self.factory.makeFilterAppointmentsViewModel()
        let viewController = self.factory.makeFilterAppointmentsViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.rootNavigationController?.present(navigationController, animated: true, completion: nil)
    }
    
}


protocol AppointmentsFactory {
    func makeAppointmentsViewController(viewModel: AppointmentsViewModelType) -> AppointmentsViewController
    func makeAppointmentsViewModel() -> AppointmentsViewModelType
    func makeAppointmentViewController(viewModel: AppointmentViewModelType) -> AppointmentViewController
    func makeAppointmentViewModel(appointment: Appointment) -> AppointmentViewModelType
    func makeFilterAppointmentsViewController(viewModel: FilterAppointmentsViewModelType) -> FilterAppointmentsViewController
    func makeFilterAppointmentsViewModel() -> FilterAppointmentsViewModelType
}

extension AppDependencyContainer: AppointmentsFactory {

}
