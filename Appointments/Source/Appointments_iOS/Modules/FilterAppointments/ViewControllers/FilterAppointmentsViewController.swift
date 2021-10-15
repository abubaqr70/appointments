// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxCocoa
import RxSwift

class FilterAppointmentsViewController: UIViewController {
    
    fileprivate lazy var titleButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.setTitle("APPOINTMENTS", for: .normal)
        button.setTitleColor(UIColor.appSkyBlue, for: .normal)
        button.titleLabel?.font = UIFont.appFont(withStyle: .title3, size: 12)
        button.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        button.setImage(UIImage.moduleImage(named: "icon_arrowup"), for: .normal)
        return button
    }()
    
    fileprivate lazy var clearButton : UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(UIColor.appSkyBlue, for: .normal)
        button.titleLabel?.font = UIFont.appFont(withStyle: .title3, size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect.zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = UIView(frame: .zero)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.appGrayLight
        return tableView
    }()
    
    private var viewModel: FilterAppointmentsViewModelType
    private let disposeBag = DisposeBag()
    
    init(viewModel : FilterAppointmentsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup(viewModel: self.viewModel)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.setDataSource(self).disposed(by: disposeBag)
    }
 
    
}
extension FilterAppointmentsViewController{
    
    private func setup(viewModel : FilterAppointmentsViewModelType) {
        setupViews()
        setupConstraints()
        registersCells()
    }
    
    private func setupViews() {
        setupNavigationBar()
        self.navigationItem.titleView = titleButton
        self.view.addSubview(clearButton)
        self.view.addSubview(tableView)
        view.backgroundColor = UIColor.appGrayLight
    }
    
    private func setupConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: safeArea.topAnchor),
            clearButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            clearButton.heightAnchor.constraint(equalToConstant: 40)
        ])
                
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: clearButton.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
    }
    
    private func registersCells() {
        tableView.register(FilterHeaderTableViewCell.self, forCellReuseIdentifier: FilterHeaderTableViewCell.reuseIdentifier)
        tableView.register(FilterAppointmentsTableViewCell.self, forCellReuseIdentifier: FilterAppointmentsTableViewCell.reuseIdentifier)
    }
    
}
extension FilterAppointmentsViewController{
    
    ///MARK:- Navigation Setup
    func setupNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.appSkyBlue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
}

extension FilterAppointmentsViewController: UITableViewDelegate,UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }else {
            return 3
        }
       
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = FilterAppointmentsTableViewCell()
            return view
        }else {
            let view = FilterHeaderTableViewCell()
            return view
        }
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterAppointmentsTableViewCell.reuseIdentifier, for: indexPath) as? FilterAppointmentsTableViewCell else {
            return UITableViewCell()
        }
    
        return cell
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
