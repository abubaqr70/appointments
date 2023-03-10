// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxCocoa
import RxSwift

class FilterAppointmentsViewController: UIViewController {
    
    private var sections: [(title: ReuseableCellViewModelType, rows: [ReuseableCellViewModelType])] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate lazy var titleButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.tintColor = UIColor.appSkyBlue
        return button
    }()
    
    fileprivate lazy var clearButton : UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(UIColor.appSkyBlue, for: .normal)
        button.titleLabel?.font = UIFont.appFont(withStyle: .title3, size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var clearButtonView : UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appBackgroundGray
        return view
    }()
    
    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect.zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = UIView(frame: .zero)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.appBackgroundGray
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.inputs.refresh.onNext(Void())
    }
    
}
extension FilterAppointmentsViewController{
    
    private func setup(viewModel : FilterAppointmentsViewModelType) {
        setupViews()
        setupConstraints()
        registersCells()
        bind(viewModel: viewModel)
    }
    
    private func setupViews() {
        setupNavigationBar()
        self.navigationItem.titleView = titleButton
        self.view.addSubview(clearButtonView)
        self.clearButtonView.addSubview(clearButton)
        self.view.addSubview(tableView)
        view.backgroundColor = UIColor.white
    }
    
    private func setupConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            clearButtonView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            clearButtonView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            clearButtonView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            clearButtonView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: clearButtonView.topAnchor),
            clearButton.trailingAnchor.constraint(equalTo: clearButtonView.trailingAnchor, constant: -20),
            clearButton.bottomAnchor.constraint(equalTo: clearButtonView.bottomAnchor),
            clearButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: clearButtonView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
    }
    
    private func registersCells() {
        tableView.register(FilterHeaderTableViewCell.self, forCellReuseIdentifier: FilterHeaderTableViewCell.reuseIdentifier)
        tableView.register(FilterAppointmentsTableViewCell.self, forCellReuseIdentifier: FilterAppointmentsTableViewCell.reuseIdentifier)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
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

extension FilterAppointmentsViewController{
    
    private func bind(viewModel : FilterAppointmentsViewModelType) {
        bindActions(viewModel: viewModel)
    }
    
    private func bindActions(viewModel : FilterAppointmentsViewModelType){
        
        viewModel.outputs.sections.subscribe({ [weak self] section in
            guard let `self` = self else { return }
            self.sections = (section.element ?? [])
        }).disposed(by: disposeBag)
        
        titleButton.rx.tap
            .bind(to: viewModel.inputs.appointmentFilterObserver)
            .disposed(by: disposeBag)
        
        clearButton.rx.tap
            .bind(to: viewModel.inputs.clear).disposed(by: disposeBag)
        
        viewModel.outputs.isAppointmentsFilterApplied.subscribe(onNext: {
            isApplied in
            if isApplied {
                self.titleButton.setImage(UIImage.moduleImage(named: "filter_appointments_up")?.withRenderingMode(.alwaysTemplate), for: .normal)
            } else {
                self.titleButton.setImage(UIImage.moduleImage(named: "appointment_up")?.withRenderingMode(.alwaysTemplate), for: .normal)
            }
        }).disposed(by: disposeBag)
        
    }
    
    
}
extension FilterAppointmentsViewController: UITableViewDelegate,UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = FilterHeaderTableViewCell()
        let element = sections[section].title
        view.configure(viewModel: element)
        return view
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterAppointmentsTableViewCell.reuseIdentifier, for: indexPath) as? FilterAppointmentsTableViewCell else {
            return UITableViewCell()
        }
        let element = sections[indexPath.section].rows[indexPath.row]
        cell.configure(viewModel: element)
        return cell
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    
}
