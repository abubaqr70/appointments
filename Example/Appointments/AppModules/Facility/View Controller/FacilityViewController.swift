// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON

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
                query.isEmpty || facility.vName.lowercased().contains(query.lowercased())
            })
        }.bind(to: facilityTblView.rx.items(cellIdentifier: "FacilityListCell", cellType: FacilityListCell.self)){
            index, tableViewItem, cell in
            cell.facility.onNext(tableViewItem)
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
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
    
}
