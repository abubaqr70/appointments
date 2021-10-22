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
    private let addActionProvider: AddActionProvider?
    private let filterActionProvider: FilterActionProvider?
    private let residentProvider: ResidentDataStore?
    
    init(root: UIViewController,
         navigationType: NavigationType,
         factory: AppointmentsFactory,
         addActionProvider: AddActionProvider?,
         filterActionProvider: FilterActionProvider?,
         residentProvider: ResidentDataStore?) {
        self.root = root
        self.navigationType = navigationType
        self.factory = factory
        self.addActionProvider = addActionProvider
        self.filterActionProvider = filterActionProvider
        self.residentProvider = residentProvider
    }
    
    public override func start() -> Observable<ResultType<Void>> {
        let viewModel = self.factory.makeAppointmentsViewModel(residentProvider: residentProvider)
        let viewController = self.factory.makeAppointmentsViewController(viewModel: viewModel)
        self.bindAppointmentViewModel(viewModel: viewModel)
        if navigationType != .push {
            
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.rootNavigationController = navigationController
            viewController.navigationItem.rightBarButtonItem = filterActionProvider?.filterAction(for: self.rootNavigationController ?? UINavigationController())
            viewController.navigationItem.leftBarButtonItem = addActionProvider?.addAction(for: self.rootNavigationController ?? UINavigationController())
            self.navigationType.navigate(to: navigationController, root: self.root)
            
        } else {
            if let root = root as? UINavigationController {
                viewController.navigationItem.leftBarButtonItems = addActionProvider?.addActionAndBackAction(for: root)
                self.navigationType.navigate(to: viewController, root: self.root)
            } else {
                fatalError("Pushing viewController on non navigation controller")
            }
        }
       
        return result
    }
    
    func bindAppointmentViewModel(viewModel : AppointmentsViewModelType) {
        viewModel.outputs.selectedAppointment.subscribe({ appointment in
            guard let appointment = appointment.element else {return}
            self.navigateToDetail(appointment: appointment)
        }).disposed(by: disposeBag)
    }
    
    func navigateToDetail(appointment: Appointment) {
        let viewModel = self.factory.makeAppointmentViewModel(appointment: appointment)
        let viewController = self.factory.makeAppointmentViewController(viewModel: viewModel)
        if navigationType != .push {
            self.rootNavigationController?.pushViewController(viewController, animated: true)
        } else {
            if let root = root as? UINavigationController {
                root.pushViewController(viewController, animated: true)
            } else {
                fatalError("Pushing viewController on non navigation controller")
            }
        }
        
    }
    
}


protocol AppointmentsFactory {
    func makeAppointmentsViewController(viewModel: AppointmentsViewModelType) -> AppointmentsViewController
    func makeAppointmentsViewModel(residentProvider: ResidentDataStore?) -> AppointmentsViewModelType
    func makeAppointmentViewController(viewModel: AppointmentViewModelType) -> AppointmentViewController
    func makeAppointmentViewModel(appointment: Appointment) -> AppointmentViewModelType
}

extension AppDependencyContainer: AppointmentsFactory {

}
