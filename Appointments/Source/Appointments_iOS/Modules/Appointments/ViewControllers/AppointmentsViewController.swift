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
    
    fileprivate lazy var filterBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "Filter",
                                   style: .plain,
                                   target: self,
                                   action: #selector(filterButtonAction))
        return item
    }()
    
    fileprivate lazy var filteredBarButtonItem: UIBarButtonItem = {
        let image = UIImage(named: "filtered")?.withRenderingMode(.alwaysOriginal)
        let item = UIBarButtonItem(image: image,
                                   style: .plain,
                                   target: self,
                                   action: #selector(filterButtonAction))
        return item
        
    }()
    
    fileprivate lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.tintColor = UIColor.black
        refreshControl.attributedTitle = NSAttributedString(string: "Syncing data, please wait.")
        return refreshControl
    }()
    
    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.appSkyBlue
        label.font = UIFont.appFont(withStyle: .body, size: 14)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var profileImage : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.image = UIImage.moduleImage(named: "image_profile_placeholder")
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    fileprivate lazy var titleButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.setTitle("APPOINTMENTS", for: .normal)
        button.setTitleColor(UIColor.appSkyBlue, for: .normal)
        button.titleLabel?.font = UIFont.appFont(withStyle: .title3, size: 14)
        button.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        button.setImage(UIImage.moduleImage(named: "icon_arrowdown"), for: .normal)
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
    
    fileprivate lazy var profileView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var residentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [segmentControl, profileView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.inputs.viewWillAppear.onNext(Void())
    }
    
    @objc func filterButtonAction(){
        self.viewModel.inputs.filterObserver.onNext(Void())
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
        self.profileView.addSubview(nameLabel)
        self.profileView.addSubview(profileImage)
        self.view.addSubview(residentStackView)
        self.view.addSubview(lastUpdatedLabel)
        self.view.addSubview(pageNavigator)
        self.view.addSubview(tableView)
        self.tableView.addSubview(refreshControl)
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
            nameLabel.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -10),
            segmentControl.heightAnchor.constraint(equalToConstant: 30),
            segmentControl.topAnchor.constraint(equalTo: residentStackView.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            profileImage.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            profileImage.topAnchor.constraint(greaterThanOrEqualTo: profileView.topAnchor),
            profileImage.bottomAnchor.constraint(greaterThanOrEqualTo: profileView.bottomAnchor, constant: -5),
            profileImage.widthAnchor.constraint(equalToConstant: 40),
            profileImage.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            residentStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            residentStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            residentStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
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
    
    private func bindLeftBarButton(viewModel : AppointmentsViewModelType){
        viewModel.outputs.isFilterApplied.subscribe(onNext: { isFilterApplied in
            if isFilterApplied {
                self.navigationItem.rightBarButtonItem = self.filteredBarButtonItem
            } else {
                self.navigationItem.rightBarButtonItem = self.filterBarButtonItem
            }
        }).disposed(by: disposeBag)
    }
    
    private func bindtextField(viewModel : AppointmentsViewModelType){
        
        viewModel.outputs.dateNavigatorTitle
            .asObservable()
            .bind(to: pageNavigator.rx.titleTextField)
            .disposed(by: disposeBag)
        
        viewModel.outputs.lastUpdatedLabel
            .bind(to: lastUpdatedLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.outputs.isRefreshing
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        viewModel.outputs.isResident.subscribe(onNext: {
            isResident in
            if isResident {
                self.isResident(viewModel: viewModel)
            }else {
                self.ifNotResident(viewModel: viewModel)
            }
        }).disposed(by: disposeBag)
        
    }
    private func isResident(viewModel : AppointmentsViewModelType) {
        self.profileView.isHidden = false
        self.segmentControl.isHidden = true
        
        self.viewModel.outputs.residentName
            .bind(to: self.nameLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.outputs.residentImage
            .subscribe(onNext: { [weak self] url in
                guard let self = self else { return }
                self.profileImage.kf.indicatorType = .activity
                self.profileImage.kf.setImage(
                    with: URL(string: url),
                    placeholder: UIImage.moduleImage(named: "image_profile_placeholder"),
                    options: [
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
            })
            .disposed(by: self.disposeBag)
        self.titleButton.setTitleColor(UIColor.black, for: .normal)
        self.titleButton.setImage(nil, for: .normal)
    }
    
    private func ifNotResident(viewModel : AppointmentsViewModelType){
        self.profileView.isHidden = true
        self.segmentControl.isHidden = false
        self.titleButton.setTitleColor(UIColor.appSkyBlue, for: .normal)
        self.titleButton.setImage(UIImage.moduleImage(named: "icon_arrowdown"), for: .normal)
        self.bindLeftBarButton(viewModel: viewModel)
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
    
        segmentControl.rx.selectedSegmentIndex
            .bind(to: viewModel.inputs.segmentControlObserver)
            .disposed(by: disposeBag)
        
        pageNavigator.dateSubject
            .bind(to: viewModel.inputs.datePickerObserver)
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: {
                viewModel.inputs.refreshControl.onNext(Void())
            }).disposed(by: disposeBag)
        
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
