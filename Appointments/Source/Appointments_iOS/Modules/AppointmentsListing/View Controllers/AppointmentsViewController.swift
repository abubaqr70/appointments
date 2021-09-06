//
//  AppointmentsViewController.swift
//  Appointments
//
//  Created by Muhammad Abubaqr on 26/08/2021.
//

import UIKit
import RxSwift
import RxCocoa

public class AppointmentsViewController: UIViewController {
    
    private var sections: [NSAttributedString] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var filter: UIBarButtonItem = {
        let filterBtn = UIBarButtonItem(title: "Filter", style: .plain, target: self, action:  #selector(didTapFilterButton(_:)))
        return filterBtn
    }()
    
    lazy var add : UIBarButtonItem = {
        let addImage    = UIImage(named: "add", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none)
        let addButton   = UIBarButtonItem(image: addImage,  style: .plain, target: self, action: #selector(didTapAddButton(_:)))
        addButton.imageInsets = UIEdgeInsets(top: 0.0, left: 10, bottom: 0, right: 10)
        return addButton
    }()
    
    lazy var titleBtn : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.setTitle("APPOINTMENTS", for: .normal)
        button.setTitleColor(UIColor(named: "appBlue", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none), for: .normal)
        button.titleLabel?.font = UIFont.appFont(withStyle: .f300, size: 12)
        button.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        button.setImage(UIImage(named: "assignee", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none), for: .normal)
        button.setImage(UIImage(named: "assignee_selected", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none), for: .selected)
        return button
    }()
    
    lazy var isAppointmentsFilter : Bool = {
        return true
    }()
    
    lazy var items: [String] = {
        let items = ["By Schedule", "By Room#"]
        return items
    }()
    
    lazy var segmentControl : UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.frame = CGRect.zero
        segmentControl.selectedSegmentIndex = 0
        let normalTextAttributes: [NSAttributedString.Key : AnyObject] = [
            NSAttributedString.Key.font :  UIFont.appFont(withStyle: .f300, size: 12)]
        segmentControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        return segmentControl
    }()
    
    lazy var lastUpdatedLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Last Updated: June 26th at 8:50 PM"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.appFont(withStyle: .f300, size: 12)
        label.backgroundColor = UIColor(named: "appDarkGray", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pageNavigator: UIPageNavigator = {
        let navigator = UIPageNavigator(frame: CGRect.zero)
        navigator.translatesAutoresizingMaskIntoConstraints = false
        navigator.backgroundColor = .white
        return navigator
    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect.zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "appLightGray", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none)
        return tableView
    }()
    
    private let dateTitle = BehaviorSubject<String?>(value: "Wednesday 01, 2016")
    private let sectionsSubject = BehaviorSubject<[NSAttributedString]>(value: [NSMutableAttributedString(string: "12:00 AM - 1:00 AM", attributes: nil),
                                                                                NSMutableAttributedString(string: "12:00 AM - 1:00 AM", attributes: nil),
                                                                                NSMutableAttributedString(string: "12:00 AM - 1:00 AM", attributes: nil),
                                                                                NSMutableAttributedString(string: "12:00 AM - 1:00 AM", attributes: nil),
                                                                                NSMutableAttributedString(string: "12:00 AM - 1:00 AM", attributes: nil),
                                                                                NSMutableAttributedString(string: "12:00 AM - 1:00 AM", attributes: nil),
                                                                                NSMutableAttributedString(string: "12:00 AM - 1:00 AM", attributes: nil)])
    private let disposeBag = DisposeBag()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.setDataSource(self).disposed(by: disposeBag)
    }
    
}

extension AppointmentsViewController{
    private func setup() {
        setupViews()
        setupConstraints()
        registersCells()
        bind()
    }
    
    private func setupViews() {
        setupNavigationBar()
        self.navigationItem.leftBarButtonItem = add
        self.navigationItem.rightBarButtonItem = filter
        self.navigationItem.titleView = titleBtn
        self.view.addSubview(segmentControl)
        self.view.addSubview(lastUpdatedLabel)
        self.view.addSubview(pageNavigator)
        self.view.addSubview(tableView)
        view.backgroundColor = .white
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
        tableView.register(AppoitmentsListCell.self, forCellReuseIdentifier: AppoitmentsListCell.reuseIdentifier)
    }
    
}
extension AppointmentsViewController{
    
    ///MARK:- Navigation Setup
    func setupNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor(named: "appBlue", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    @objc func didTapAddButton(_ sender: UIBarButtonItem){
        
    }
    
    @objc func didTapFilterButton(_ sender: UIBarButtonItem){
        
    }
}

extension AppointmentsViewController{
    
    private func bind() {
        dateTitle
            .asObservable()
            .bind(to: pageNavigator.rx.titleBtn)
            .disposed(by: disposeBag)
        
        sectionsSubject
            .subscribe(onNext: { [weak self] sections in
                guard let `self` = self else { return }
                self.sections = sections
            }).disposed(by: disposeBag)
        
        titleBtn.rx.tap
            .bind {
                if !self.titleBtn.isSelected{
                    self.titleBtn.isSelected = true
                }else{
                    self.titleBtn.isSelected = false
                }
                print("button tapped")
            }
            .disposed(by: disposeBag)
    }
    
}

extension AppointmentsViewController: UITableViewDelegate,UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderTableViewCell()
        view.rx.heading.onNext(sections[section])
        return view
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppoitmentsListCell.reuseIdentifier, for: indexPath) as? AppoitmentsListCell
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let appointemmetsDetail = AppointmentsDetailViewController()
//        self.navigationController?.pushViewController(appointemmetsDetail, animated: true)
    }
}
