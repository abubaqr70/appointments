// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxSwift
import RxCocoa
import Appointments

class FacilityViewController: BaseViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var facilityTblView: UITableView!
    
    private lazy var viewModel : FacilityViewModelType = FacilityViewModel()
    let searchText = BehaviorSubject<String>(value: "")
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearNavigation()
        addLogoutBtn()
        self.navigationItem.title = "Facilities"
        self.facilityTblView.register(UINib(nibName: "FacilityListCell", bundle: nil), forCellReuseIdentifier: "FacilityListCell")
        
        addSearchBarObserver()
        Observable.combineLatest(viewModel.outputs.facilitiesObservable, searchText) { facilities, query in
            return facilities.filter({ facility in
                query.isEmpty || facility.v_name?.lowercased().contains(query.lowercased()) ?? false
            })
        }.bind(to: facilityTblView.rx.items(cellIdentifier: "FacilityListCell", cellType: FacilityListCell.self)){
            index, tableViewItem, cell in
            cell.facility.onNext(tableViewItem)
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        self.facilityTblView.rx.modelSelected(Facilities.self).subscribe(onNext: { [weak self]
            facility in
            guard let self = self else {return}
            do{
                let data = try JSONEncoder().encode(facility)
                do {
                    let responseModel = try? JSONSerialization.jsonObject(with: data, options: [])
                    guard let dictionary = responseModel as? [String : Any] else {
                        return
                    }
                    self.didSelect(facility: dictionary)
                }
            }catch let error as NSError{
                print(error.localizedDescription)
            }
        }).disposed(by: disposeBag)
        
    }
    
    private func addSearchBarObserver() {
        searchBar
            .rx
            .text
            .orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe { [weak self] query in
                guard
                    let query = query.element else { return }
                self?.searchText.onNext(query)
            }
            .disposed(by: disposeBag)
    }
    
    private func didSelect(facility: [String:Any]){
        let appDependency = AppDependencyContainer(baseURL: APPURL.Domain,
                                                   authentication: AuthenticationProvider.init(),
                                                   userDataStore: UserProvider.init(),
                                                   facilityDataStore: FacilityProvider.init(facility: facility),
                                                   addActionProvider: nil,
                                                   filterActionProvider: nil)
        
        let appCoordinator = appDependency.makeAppointmentsCoordinator(root: self.navigationController ?? UINavigationController(),
                                                                       navigationType: .present)
        appCoordinator
            .start()
            .subscribe()
            .disposed(by: disposeBag)
        
    }
    
}
