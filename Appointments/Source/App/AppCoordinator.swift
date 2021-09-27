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
        
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.rootNavigationController = navigationController
        
        
        self.navigationType.navigate(to: navigationController, root: self.root)
        
        return result
    }
    
}


protocol AppointmentsFactory {
    func makeAppointmentsViewController(viewModel: AppointmentsViewModelType) -> AppointmentsViewController
    func makeAppointmentsViewModel() -> AppointmentsViewModelType
}

extension AppDependencyContainer: AppointmentsFactory {

}
