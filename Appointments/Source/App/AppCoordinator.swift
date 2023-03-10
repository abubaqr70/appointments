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
    private let facilityDataStore: FacilityDataStore
    private let permissionProvider: PermissionProvider
    
    init(root: UIViewController,
         navigationType: NavigationType,
         factory: AppointmentsFactory,
         addActionProvider: AddActionProvider?,
         filterActionProvider: FilterActionProvider?,
         residentProvider: ResidentDataStore?,
         facilityDataStore: FacilityDataStore,
         permissionProvider: PermissionProvider) {
        self.root = root
        self.navigationType = navigationType
        self.factory = factory
        self.addActionProvider = addActionProvider
        self.filterActionProvider = filterActionProvider
        self.residentProvider = residentProvider
        self.facilityDataStore = facilityDataStore
        self.permissionProvider = permissionProvider
    }
    
    public override func start() -> Observable<ResultType<Void>> {
        let viewModel = self.factory.makeAppointmentsViewModel(residentProvider: residentProvider,
                                                               filterActionProvider: filterActionProvider,
                                                               facilityDataStore: facilityDataStore,
                                                               permissionProvider: permissionProvider)
        let viewController = self.factory.makeAppointmentsViewController(viewModel: viewModel)
        self.bindAppointmentViewModel(viewModel: viewModel)
        if navigationType != .push {
            
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.rootNavigationController = navigationController
            self.filterActionProvider?.addNavigation(for: self.rootNavigationController ?? UINavigationController())
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
        
        viewModel.outputs.filterAppointments.subscribe(onNext: {
            self.presentFilterAppointments(facilityDataStore: viewModel.outputs.facilityDataStoreOutput)
        }).disposed(by: disposeBag)
    }
    
    func navigateToDetail(appointment: Appointment) {
        let viewModel = self.factory.makeAppointmentViewModel(appointment: appointment,
                                                              permissionProvider: permissionProvider)
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
    
    func presentFilterAppointments(facilityDataStore: FacilityDataStore) {
        let viewModel = self.factory.makeFilterAppointmentsViewModel(facilityDataStore: facilityDataStore)
        let viewController = self.factory.makeFilterAppointmentsViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        if navigationType != .push {
            self.rootNavigationController?.present(navigationController, animated: true, completion: nil)
        } else {
            if let root = root as? UINavigationController {
                root.present(navigationController, animated: true, completion: nil)
            } else {
                fatalError("Pushing viewController on non navigation controller")
            }
        }
        
        
        viewModel.outputs.filterAppointments.subscribe(onNext: {
            
            if self.navigationType != .push {
                self.rootNavigationController?.dismiss(animated: true, completion: nil)
            } else {
                if let root = self.root as? UINavigationController {
                    root.dismiss(animated: true, completion: nil)
                } else {
                    fatalError("Pushing viewController on non navigation controller")
                }
            }
        }).disposed(by: disposeBag)
    }
    
}


protocol AppointmentsFactory {
    func makeAppointmentsViewController(viewModel: AppointmentsViewModelType) -> AppointmentsViewController
    func makeAppointmentsViewModel(residentProvider: ResidentDataStore?,
                                   filterActionProvider: FilterActionProvider?,
                                   facilityDataStore: FacilityDataStore,
                                   permissionProvider: PermissionProvider) -> AppointmentsViewModelType
    func makeAppointmentViewController(viewModel: AppointmentViewModelType) -> AppointmentViewController
    func makeAppointmentViewModel(appointment: Appointment,
                                  permissionProvider: PermissionProvider) -> AppointmentViewModelType
    func makeFilterAppointmentsViewController(viewModel: FilterAppointmentsViewModelType) -> FilterAppointmentsViewController
    func makeFilterAppointmentsViewModel(facilityDataStore: FacilityDataStore) -> FilterAppointmentsViewModelType
}

extension AppDependencyContainer: AppointmentsFactory {

}
