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
        let viewModel = self.factory.makeAppointmentsViewModel()
        let viewController = self.factory.makeAppointmentsViewController(viewModel: viewModel)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        self.root.present(navigationController, animated: true)
        
        return result
    }
}


protocol AppointmentsFactory {
    func makeAppointmentsViewController(viewModel: AppointmentsViewModelType) -> AppointmentsViewController
    func makeAppointmentsViewModel() -> AppointmentsViewModelType
}

extension AppDependencyContainer: AppointmentsFactory { }
