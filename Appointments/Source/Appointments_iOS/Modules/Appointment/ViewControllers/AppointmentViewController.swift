// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

public class AppointmentViewController: UIViewController {
    
    fileprivate lazy var backButton : UIBarButtonItem = {
        let backImage    = UIImage.moduleImage(named: "icon_back_arrow")
        let backButton   = UIBarButtonItem(image: backImage,  style: .plain, target: self, action: #selector(didTapBackButton(_:)))
        backButton.imageInsets = UIEdgeInsets(top: 0.0, left: 10, bottom: 0, right: 10)
        return backButton
    }()
    
    fileprivate lazy var navTitleLabel : UILabel = {
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        title.text = "APPOINTMENTS"
        title.font = UIFont.appFont(withStyle: .title3, size: 12)
        title.textAlignment = .center
        title.textColor = UIColor.appSkyBlue
        return title
    }()
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .appBackgroundGray
        return scrollView
    }()
    
    fileprivate lazy var contentView : UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .appBackgroundGray
        return contentView
    }()
    
    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.appFont(withStyle: .title2, size: 16)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var roomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.appGrayDark
        label.font = UIFont.appFont(withStyle: .title2, size: 14)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var appointmentDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .black
        textView.isUserInteractionEnabled = false
        textView.sizeToFit()
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.backgroundColor = UIColor.appBackgroundGray
        return textView
    }()
    
    fileprivate lazy var appointmentTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.appFont(withStyle: .body, size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.appFont(withStyle: .title2, size: 14)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var staffLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate lazy var appointmentTypeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate lazy var locationLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var markPresentButton : UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.backgroundColor = UIColor.appBackgroundGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var userProfileImage : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 21
        view.clipsToBounds = true
        return view
    }()
    
    fileprivate lazy var lineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.appGrayLight
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.appFont(withStyle: .title2, size: 13)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var timeView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.appLightSkyBlue
        view.layer.cornerRadius = 3
        return view
    }()
    
    fileprivate lazy var namesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, roomLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    fileprivate lazy var profileNamesView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.appBackgroundGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func showActivity(){
        SVProgressHUD.show(withStatus: "Updating Appointments")
        SVProgressHUD.setFont(UIFont.boldSystemFont(ofSize: 16))
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

    private let disposeBag = DisposeBag()
    private var viewModel: AppointmentViewModelType
    
    init(viewModel : AppointmentViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup(viewModel: self.viewModel)
    }
    
}
extension AppointmentViewController{
    private func setup(viewModel : AppointmentViewModelType) {
        setupViews()
        setupConstraints()
        bind(viewModel: viewModel)
    }
    
    private func setupViews() {
        setupNavigationBar()
        self.navigationItem.leftBarButtonItem  = backButton
        self.navigationItem.titleView = navTitleLabel
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(profileNamesView)
        self.profileNamesView.addSubview(userProfileImage)
        self.profileNamesView.addSubview(namesStackView)
        self.contentView.addSubview(lineView)
        self.contentView.addSubview(appointmentTitleLabel)
        self.contentView.addSubview(timeView)
        self.timeView.addSubview(timeLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(staffLabel)
        self.contentView.addSubview(appointmentTypeLabel)
        self.contentView.addSubview(locationLabel)
        self.contentView.addSubview(appointmentDescriptionTextView)
        self.contentView.addSubview(markPresentButton)
        view.backgroundColor = .appBackgroundGray
    }
    
    private func setupConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profileNamesView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            profileNamesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            profileNamesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            userProfileImage.leadingAnchor.constraint(equalTo: profileNamesView.leadingAnchor),
            userProfileImage.centerYAnchor.constraint(equalTo: profileNamesView.centerYAnchor),
            userProfileImage.topAnchor.constraint(equalTo: profileNamesView.topAnchor),
            userProfileImage.bottomAnchor.constraint(greaterThanOrEqualTo: profileNamesView.bottomAnchor, constant: -5),
            userProfileImage.widthAnchor.constraint(equalToConstant: 42),
            userProfileImage.heightAnchor.constraint(equalToConstant: 42)
        ])
        
        NSLayoutConstraint.activate([
            namesStackView.topAnchor.constraint(greaterThanOrEqualTo: profileNamesView.topAnchor, constant: 5),
            namesStackView.bottomAnchor.constraint(greaterThanOrEqualTo: profileNamesView.bottomAnchor, constant: -5),
            namesStackView.centerYAnchor.constraint(equalTo: profileNamesView.centerYAnchor),
            namesStackView.leadingAnchor.constraint(equalTo: userProfileImage.trailingAnchor, constant: 10),
            namesStackView.trailingAnchor.constraint(equalTo: profileNamesView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: profileNamesView.bottomAnchor,constant: 10),
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            appointmentTitleLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor,constant: 10),
            appointmentTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            appointmentTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            timeView.topAnchor.constraint(equalTo: appointmentTitleLabel.bottomAnchor,constant: 10),
            timeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            timeView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -15),
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: timeView.topAnchor,constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: timeView.leadingAnchor, constant: 20),
            timeLabel.trailingAnchor.constraint(equalTo: timeView.trailingAnchor, constant: -20),
            timeLabel.bottomAnchor.constraint(equalTo: timeView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: timeView.bottomAnchor,constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            staffLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,constant: 10),
            staffLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            staffLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            appointmentTypeLabel.topAnchor.constraint(equalTo: staffLabel.bottomAnchor,constant: 10),
            appointmentTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            appointmentTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: appointmentTypeLabel.bottomAnchor,constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            appointmentDescriptionTextView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor,constant: 10),
            appointmentDescriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            appointmentDescriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
        
        NSLayoutConstraint.activate([
            markPresentButton.topAnchor.constraint(equalTo: appointmentDescriptionTextView.bottomAnchor,constant: 20),
            markPresentButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            markPresentButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            markPresentButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -30),
            markPresentButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
}
extension AppointmentViewController{
    
    private func bind(viewModel : AppointmentViewModelType) {
        
        //Mark:- Setting Name Label
        Observable.combineLatest(viewModel.outputs.name, viewModel.outputs.authorizedToViewTitleAppointments, viewModel.outputs.authorizedToViewTitleAndDescriptionAppointments, viewModel.outputs.authorizedToManageAppointments).map{
            name, viewTitle, viewTitleAndDescription, manageAppointments -> Bool in
            if manageAppointments {
                guard let name = name else {return true}
                return name.isEmpty
            } else {
                if viewTitle || viewTitleAndDescription {
                    return true
                } else {
                    guard let name = name else {return true}
                    return name.isEmpty
                }
            }
        }.bind(to: self.nameLabel.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.outputs.name
            .bind(to: self.nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        //Mark:- Setting Room Label
        Observable.combineLatest(viewModel.outputs.room, viewModel.outputs.authorizedToViewTitleAppointments, viewModel.outputs.authorizedToViewTitleAndDescriptionAppointments, viewModel.outputs.authorizedToManageAppointments).map{
            roomNo, viewTitle, viewTitleAndDescription, manageAppointments -> Bool in
            if manageAppointments {
                guard let roomNo = roomNo else {return true}
                return roomNo.isEmpty
            } else {
                if viewTitle || viewTitleAndDescription {
                    return true
                } else {
                    guard let roomNo = roomNo else {return true}
                    return roomNo.isEmpty
                }
            }
        }.bind(to: self.roomLabel.rx.isHidden).disposed(by: disposeBag)
     
        viewModel.outputs.room
            .map {
                roomNo -> String in
                return ("Room # \(roomNo ?? "")")
            }
            .bind(to: self.roomLabel.rx.text)
            .disposed(by: disposeBag)
        
        //Mark:- Setting Appointment Title Label
        viewModel.outputs.appointmentTitle
            .map{
                title -> Bool in
                guard let title = title else {return true}
                return title.isEmpty
            }
            .bind(to: self.appointmentTitleLabel.rx.isHidden).disposed(by: disposeBag)
      
        viewModel.outputs.appointmentTitle
            .bind(to: self.appointmentTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        //Mark:- Setting Appointment Type Label
        Observable.combineLatest(viewModel.outputs.appointmentType, viewModel.outputs.authorizedToViewTitleAppointments, viewModel.outputs.authorizedToViewTitleAndDescriptionAppointments, viewModel.outputs.authorizedToManageAppointments).map{
            appointmentType, viewTitle, viewTitleAndDescription, manageAppointments -> Bool in
            if manageAppointments {
                guard let appointmentType = appointmentType else {return true}
                return appointmentType.string == "Appointment Type: "
            } else {
                if viewTitle || viewTitleAndDescription {
                    return true
                } else {
                    guard let appointmentType = appointmentType else {return true}
                    return appointmentType.string == "Appointment Type: "
                }
            }
        }.bind(to: self.appointmentTypeLabel.rx.isHidden).disposed(by: disposeBag)
    
        viewModel.outputs.appointmentType
            .bind(to: self.appointmentTypeLabel.rx.attributedText)
            .disposed(by: disposeBag)
        
        //Mark:- Setting Location Label
        Observable.combineLatest(viewModel.outputs.location, viewModel.outputs.authorizedToViewTitleAppointments, viewModel.outputs.authorizedToViewTitleAndDescriptionAppointments, viewModel.outputs.authorizedToManageAppointments).map{
            location, viewTitle, viewTitleAndDescription, manageAppointments -> Bool in
            if manageAppointments {
                guard let location = location else {return true}
                return location.string == "Location: "
            } else {
                if viewTitle || viewTitleAndDescription {
                    return true
                } else {
                    guard let location = location else {return true}
                    return location.string == "Location: "
                }
            }
        }.bind(to: self.locationLabel.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.outputs.location
            .bind(to: self.locationLabel.rx.attributedText)
            .disposed(by: disposeBag)
        
        //Mark:- Setting Date Label
        viewModel.outputs.date
            .map { date -> Bool in
                guard let date = date else {return true}
                return date.isEmpty
            }
            .bind(to: self.dateLabel.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.outputs.date
            .bind(to: self.dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        //Mark:- Setting Time Label
        viewModel.outputs.time
            .map { time -> Bool in
                guard let time = time else {return true}
                return time.isEmpty
            }
            .bind(to: self.timeLabel.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.outputs.time
            .bind(to: self.timeLabel.rx.text)
            .disposed(by: disposeBag)
        
        //Mark:- Setting Staff Label
        Observable.combineLatest(viewModel.outputs.staff, viewModel.outputs.authorizedToViewTitleAppointments, viewModel.outputs.authorizedToViewTitleAndDescriptionAppointments, viewModel.outputs.authorizedToManageAppointments).map{
            staff, viewTitle, viewTitleAndDescription, manageAppointments -> Bool in
            if manageAppointments {
                guard let staff = staff else {return true}
                return staff.string == "Staff: " || staff.string == "Staff:  "
            } else {
                if viewTitle || viewTitleAndDescription {
                    return true
                } else {
                    guard let staff = staff else {return true}
                    return staff.string == "Staff: " || staff.string == "Staff:  "
                }
            }
        }.bind(to: self.staffLabel.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.outputs.staff
            .bind(to: self.staffLabel.rx.attributedText)
            .disposed(by: disposeBag)
        
        //Mark:- Setting Appointments Description Label
        Observable.combineLatest(viewModel.outputs.appointmentDescription, viewModel.outputs.authorizedToViewTitleAndDescriptionAppointments, viewModel.outputs.authorizedToManageAppointments).map{
            description, viewTitleAndDescription, manageAppointments -> Bool in
            if manageAppointments {
                guard let description = description else {return true}
                return description.string == ""
            } else {
                if viewTitleAndDescription {
                    guard let description = description else {return true}
                    return description.string == ""
                } else {
                    return true
                }
            }
        }.bind(to: self.appointmentDescriptionTextView.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.outputs.appointmentDescription
            .bind(to: self.appointmentDescriptionTextView.rx.attributedText)
            .disposed(by: disposeBag)
        
        //Mark:- Setting Profile Image
        
        Observable.combineLatest(viewModel.outputs.profileImage, viewModel.outputs.authorizedToViewTitleAppointments, viewModel.outputs.authorizedToViewTitleAndDescriptionAppointments, viewModel.outputs.authorizedToManageAppointments).subscribe(onNext: {
            [weak self] url, viewTitle, viewTitleAndDescription, manageAppointments in
            guard let self = self else { return }
            var urlImage = url
            if manageAppointments {
                urlImage = url
            } else {
                if viewTitle || viewTitleAndDescription {
                   urlImage = ""
                } else {
                    urlImage = url
                }
            }
            self.userProfileImage.kf.indicatorType = .activity
            self.userProfileImage.kf.setImage(
                with: URL(string: urlImage ?? ""),
                placeholder: UIImage.moduleImage(named: "image_profile_placeholder"),
                options: [
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        }).disposed(by: disposeBag)
 
        //Mark:- Mark Present Button Action
        markPresentButton.rx.tap
            .bind(to: viewModel.inputs.markPresent)
            .disposed(by: disposeBag)
        
        viewModel.outputs.isPresent
            .subscribe(onNext: { [weak self] selected in
                guard let self = self else { return }
                if selected {
                    self.markPresentButton.setImage(UIImage.moduleImage(named: "image_present"), for: .normal)
                }else{
                    self.markPresentButton.setImage(UIImage.moduleImage(named: "image_mark_present"), for: .normal)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.markPresentEnabled
            .subscribe(onNext: { [weak self] selected in
                guard let self = self else { return }
                self.markPresentButton.rx.isEnabled.onNext(selected)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.isLoading
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] loading in
                guard let `self` = self else { return }
                loading ? self.showActivity() : self.dismissActivity()
            })
            .disposed(by: disposeBag)
        
        
    }
    
}
extension AppointmentViewController{
    
    ///MARK:- Navigation Setup
    func setupNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = .appBackgroundGray
        self.navigationController?.navigationBar.tintColor = UIColor.appSkyBlue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    @objc func didTapBackButton(_ sender: UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }
    
}
