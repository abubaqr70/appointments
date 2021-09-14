// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxSwift
import RxCocoa

public class AppointmentsViewController: UIViewController {
    
    private var sections: [NSAttributedString] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate lazy var filter_button: UIBarButtonItem = {
        let filterBtn = UIBarButtonItem(title: "Filter", style: .plain, target: self, action:  #selector(didTapFilterButton(_:)))
        return filterBtn
    }()
    
    fileprivate lazy var add_button : UIBarButtonItem = {
        let addImage    = UIImage(named: "icon_add", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none)
        let addButton   = UIBarButtonItem(image: addImage,  style: .plain, target: self, action: #selector(didTapAddButton(_:)))
        addButton.imageInsets = UIEdgeInsets(top: 0.0, left: 10, bottom: 0, right: 10)
        return addButton
    }()
    
    fileprivate lazy var title_button : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.setTitle("APPOINTMENTS", for: .normal)
        button.setTitleColor(UIColor(named: "color_app_blue", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none), for: .normal)
        button.titleLabel?.font = UIFont.appFont(withStyle: .title3, size: 12)
        button.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        button.setImage(UIImage(named: "icon_arrowdown", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none), for: .normal)
        button.setImage(UIImage(named: "icon_arrowup", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none), for: .selected)
        return button
    }()
    
    
    fileprivate lazy var items: [String] = {
        let items = ["By Schedule", "By Room#"]
        return items
    }()
    
    fileprivate lazy var segment_control : UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.frame = CGRect.zero
        segmentControl.selectedSegmentIndex = 0
        let normalTextAttributes: [NSAttributedString.Key : AnyObject] = [
            NSAttributedString.Key.font :  UIFont.appFont(withStyle: .title3, size: 12)]
        segmentControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        return segmentControl
    }()
    
    fileprivate lazy var last_updated_label: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Last Updated: June 26th at 8:50 PM"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.appFont(withStyle: .title3, size: 12)
        label.backgroundColor = UIColor(named: "color_app_dark_gray", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var page_navigator: UIPageNavigator = {
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
        tableView.backgroundColor = UIColor(named: "color_app_light_gray", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none)
        return tableView
    }()
    
    private let date_navigator_title = BehaviorSubject<String?>(value: "Wednesday 01, 2016")
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
        self.navigationItem.leftBarButtonItem = add_button
        self.navigationItem.rightBarButtonItem = filter_button
        self.navigationItem.titleView = title_button
        self.view.addSubview(segment_control)
        self.view.addSubview(last_updated_label)
        self.view.addSubview(page_navigator)
        self.view.addSubview(tableView)
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            segment_control.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            segment_control.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            segment_control.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            segment_control.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            last_updated_label.topAnchor.constraint(equalTo: segment_control.bottomAnchor, constant: 10),
            last_updated_label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            last_updated_label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            last_updated_label.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            page_navigator.topAnchor.constraint(equalTo: last_updated_label.bottomAnchor, constant: 10),
            page_navigator.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            page_navigator.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            page_navigator.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: page_navigator.bottomAnchor, constant: 10),
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
        self.navigationController?.navigationBar.tintColor = UIColor(named: "color_app_blue", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    @objc func didTapAddButton(_ sender: UIBarButtonItem){
        
    }
    
    @objc func didTapFilterButton(_ sender: UIBarButtonItem){
        
    }
}

extension AppointmentsViewController{
    
    private func bind() {
        date_navigator_title
            .asObservable()
            .bind(to: page_navigator.rx.titleBtn)
            .disposed(by: disposeBag)
        
        sectionsSubject
            .subscribe(onNext: { [weak self] sections in
                guard let `self` = self else { return }
                self.sections = sections
            }).disposed(by: disposeBag)
        
        title_button.rx.tap
            .bind {
                if !self.title_button.isSelected{
                    self.title_button.isSelected = true
                }else{
                    self.title_button.isSelected = false
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
        let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentTableViewCell.reuseIdentifier, for: indexPath) as? AppointmentTableViewCell
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let appointemmetsDetail = AppointmentsDetailViewController()
        //        self.navigationController?.pushViewController(appointemmetsDetail, animated: true)
    }
}
