// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

public class AppointmentsViewController: UIViewController {
    
    private var sections: [(title: String, rows: [ReuseableCellViewModelType])] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate lazy var titleButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.setTitle("APPOINTMENTS", for: .normal)
        button.setTitleColor(UIColor.appSkyBlue, for: .normal)
        button.titleLabel?.font = UIFont.appFont(withStyle: .title3, size: 12)
        button.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        button.setImage(UIImage.moduleImage(named: "icon_arrowdown"), for: .normal)
        button.setImage(UIImage.moduleImage(named: "icon_arrowup"), for: .selected)
        return button
    }()
    
    fileprivate lazy var segmentControl : UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["By Schedule", "By Room#"])
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.frame = CGRect.zero
        segmentControl.selectedSegmentIndex = 0
        let normalTextAttributes: [NSAttributedString.Key : AnyObject] = [
            NSAttributedString.Key.font :  UIFont.appFont(withStyle: .title3, size: 12)]
        segmentControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        return segmentControl
    }()
    
    fileprivate lazy var lastUpdatedLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.appFont(withStyle: .title3, size: 12)
        label.backgroundColor = UIColor.appGrayDark
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var pageNavigator: UIPageNavigator = {
        let navigator = UIPageNavigator(frame: CGRect.zero)
        navigator.translatesAutoresizingMaskIntoConstraints = false
        navigator.backgroundColor = .white
        return navigator
    }()
    
    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect.zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.appGrayLight
        return tableView
    }()
    
    
    private var viewModel: AppointmentsViewModelType
    private let disposeBag = DisposeBag()
    
    init(viewModel : AppointmentsViewModelType) {
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

extension AppointmentsViewController{
    
    private func setup(viewModel : AppointmentsViewModelType) {
        setupViews()
        setupConstraints()
        registersCells()
        bind(viewModel: viewModel)
    }
    
    private func setupViews() {
        setupNavigationBar()
        
        self.navigationItem.titleView = titleButton
        self.view.addSubview(segmentControl)
        self.view.addSubview(lastUpdatedLabel)
        self.view.addSubview(pageNavigator)
        self.view.addSubview(tableView)
        view.backgroundColor = .white
    }
    
    private func showActivity(){
        SVProgressHUD.show(withStatus: "Loading")
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setForegroundColor(UIColor.white)                                         //Ring Color
        SVProgressHUD.setBackgroundColor(UIColor.black.withAlphaComponent(0.8))                 //HUD Color
        SVProgressHUD.setBackgroundLayerColor(UIColor.clear)                                    //Background Color
    }
    
    private func dismissActivity(){
        SVProgressHUD.dismiss()
    }
    
    
    private func setupConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            segmentControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            segmentControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            segmentControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            lastUpdatedLabel.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 10),
            lastUpdatedLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            lastUpdatedLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            lastUpdatedLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            pageNavigator.topAnchor.constraint(equalTo: lastUpdatedLabel.bottomAnchor, constant: 10),
            pageNavigator.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            pageNavigator.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            pageNavigator.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: pageNavigator.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
    }
    
    private func registersCells() {
        tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.reuseIdentifier)
        tableView.register(AppointmentTableViewCell.self, forCellReuseIdentifier: AppointmentTableViewCell.reuseIdentifier)
    }
    
}
extension AppointmentsViewController{
    
    ///MARK:- Navigation Setup
    func setupNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.appSkyBlue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
}

extension AppointmentsViewController{
    
    private func bind(viewModel : AppointmentsViewModelType) {
        
        viewModel.outputs.sections.subscribe({ [weak self] section in
            guard let `self` = self else { return }
            self.sections = (section.element ?? [])
        }).disposed(by: disposeBag)
   
        viewModel.outputs.isLoading
            .subscribe(onNext: { [weak self] loading in
                guard let `self` = self else { return }
                loading ? self.showActivity() : self.dismissActivity()
            })
            .disposed(by: disposeBag)
        
        bindtextField(viewModel: viewModel)
        bindActions(viewModel: viewModel)
        bindErrorAlert(viewModel: viewModel)
    }
    
    private func bindtextField(viewModel : AppointmentsViewModelType){
        
        viewModel.outputs.dateNavigatorTitle
            .asObservable()
            .bind(to: pageNavigator.rx.titleTextField)
            .disposed(by: disposeBag)
        
    }
    
    private func bindActions(viewModel : AppointmentsViewModelType){
        
        pageNavigator.rx.next
            .bind(to: viewModel.inputs.nextDateObserver)
            .disposed(by: disposeBag)
        
        pageNavigator.rx.previous
            .bind(to: viewModel.inputs.previousDateObserver)
            .disposed(by: disposeBag)
        
        titleButton.rx.tap
            .bind(to: viewModel.inputs.appointmentFilterObserver)
            .disposed(by: disposeBag)
        
        titleButton.rx.tap
            .map { [weak self] _ in
                guard let self = self else { return false }
                return !self.titleButton.isSelected
            }
            .bind(to: titleButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        segmentControl.rx.selectedSegmentIndex
            .bind(to: viewModel.inputs.segmentControlObserver)
            .disposed(by: disposeBag)
        
        pageNavigator.dateSubject
            .bind(to: viewModel.inputs.datePickerObserver)
            .disposed(by: disposeBag)
        
    }
    
    private func bindErrorAlert(viewModel: AppointmentsViewModelType) {
        
        viewModel.outputs.errorAlert
            .subscribe(onNext: { [weak self] message in
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(cancelAction)
                self?.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
}

extension AppointmentsViewController: UITableViewDelegate,UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderTableViewCell()
        view.rx.heading.onNext(sections[section].title)
        return view
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentTableViewCell.reuseIdentifier, for: indexPath) as? AppointmentTableViewCell else {
            return UITableViewCell()
        }
        
        let element = sections[indexPath.section].rows[indexPath.row]
        cell.configure(viewModel: element)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cellViewModel = sections[indexPath.section].rows[indexPath.row] as? AppointmentTVCellViewModelType{
            cellViewModel.outputs.appointment.subscribe(onNext: { appointment in
                self.viewModel.inputs.selectAppointment.onNext(appointment)
            }).dispose()
        }
    }
}
