// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class AppointmentTableViewCell: RxUITableViewCell {
    
    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.appFont(withStyle: .body, size: 16)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var roomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.appGrayDark
        label.font = UIFont.appFont(withStyle: .title3, size: 14)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var appointmentDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.appFont(withStyle: .title3, size: 14)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var staffLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.appGrayDark
        label.font = UIFont.appFont(withStyle: .title3, size: 14)
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
    
    fileprivate lazy var checkboxButton : UIButton = {
        let checkboxButton = UIButton(frame: CGRect.zero)
        checkboxButton.backgroundColor = UIColor.white
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return checkboxButton
    }()
    
    fileprivate lazy var arrowImage : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.image = UIImage.moduleImage(named: "icon_date_right")
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var lineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.appGrayLight
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var cellView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()
    
    fileprivate lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, roomLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    fileprivate lazy var imageNameView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var buttonAppointmentsView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var viewModel: AppointmentTVCellViewModelType?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setup()
    }
    
    private func setup() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        selectionStyle = .none
        contentView.addSubview(cellView)
        cellView.addSubview(imageNameView)
        cellView.addSubview(lineView)
        cellView.addSubview(buttonAppointmentsView)
        imageNameView.addSubview(profileImage)
        imageNameView.addSubview(nameStackView)
        imageNameView.addSubview(arrowImage)
        buttonAppointmentsView.addSubview(checkboxButton)
        buttonAppointmentsView.addSubview(appointmentDescriptionLabel)
        buttonAppointmentsView.addSubview(staffLabel)
        contentView.backgroundColor = UIColor.appGrayLight
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            imageNameView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            imageNameView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            imageNameView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: imageNameView.leadingAnchor),
            profileImage.centerYAnchor.constraint(equalTo: imageNameView.centerYAnchor),
            profileImage.topAnchor.constraint(greaterThanOrEqualTo: imageNameView.topAnchor),
            profileImage.bottomAnchor.constraint(greaterThanOrEqualTo: imageNameView.bottomAnchor, constant: -5),
            profileImage.widthAnchor.constraint(equalToConstant: 40),
            profileImage.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            nameStackView.topAnchor.constraint(greaterThanOrEqualTo: imageNameView.topAnchor, constant: 5),
            nameStackView.bottomAnchor.constraint(greaterThanOrEqualTo: imageNameView.bottomAnchor, constant: -5),
            nameStackView.centerYAnchor.constraint(equalTo: imageNameView.centerYAnchor),
            nameStackView.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            arrowImage.centerYAnchor.constraint(equalTo: imageNameView.centerYAnchor),
            arrowImage.leadingAnchor.constraint(equalTo: nameStackView.trailingAnchor, constant: 10),
            arrowImage.trailingAnchor.constraint(equalTo: imageNameView.trailingAnchor, constant: -10),
            arrowImage.widthAnchor.constraint(equalToConstant: 10),
            arrowImage.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: imageNameView.bottomAnchor,constant: 5),
            lineView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 60),
            lineView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            buttonAppointmentsView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            buttonAppointmentsView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            buttonAppointmentsView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor,constant: -10),
            buttonAppointmentsView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            checkboxButton.leadingAnchor.constraint(equalTo: buttonAppointmentsView.leadingAnchor),
            checkboxButton.centerYAnchor.constraint(equalTo: buttonAppointmentsView.centerYAnchor),
            checkboxButton.topAnchor.constraint(greaterThanOrEqualTo: buttonAppointmentsView.topAnchor,constant: 10),
            checkboxButton.heightAnchor.constraint(equalToConstant: 40),
            checkboxButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            appointmentDescriptionLabel.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor),
            appointmentDescriptionLabel.centerYAnchor.constraint(equalTo: buttonAppointmentsView.centerYAnchor),
            appointmentDescriptionLabel.topAnchor.constraint(greaterThanOrEqualTo: buttonAppointmentsView.topAnchor, constant: 5),
            appointmentDescriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: buttonAppointmentsView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            staffLabel.leadingAnchor.constraint(greaterThanOrEqualTo: appointmentDescriptionLabel.trailingAnchor,constant: 10),
            staffLabel.trailingAnchor.constraint(equalTo: buttonAppointmentsView.trailingAnchor,constant: -10),
            staffLabel.centerYAnchor.constraint(equalTo: buttonAppointmentsView.centerYAnchor),
            staffLabel.topAnchor.constraint(greaterThanOrEqualTo: buttonAppointmentsView.topAnchor,constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
        ])
        
        appointmentDescriptionLabel.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        appointmentDescriptionLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        
        appointmentDescriptionLabel.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        appointmentDescriptionLabel.setContentCompressionResistancePriority(.defaultLow + 1, for: .horizontal)
        
    }
    
    override func configure(viewModel: Any) {
        guard let viewModel = viewModel as? AppointmentTVCellViewModelType else { return }
        self.viewModel = viewModel
        bind(viewModel: viewModel)
    }
    
    private func bind(viewModel : AppointmentTVCellViewModelType) {
        
        viewModel.outputs.name
            .map { name -> Bool in
                guard let name = name else {return true}
                return name.isEmpty
            }
            .bind(to: self.nameLabel.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.outputs.name
            .bind(to: self.nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.outputs.room
            .map { roomNo -> Bool in
                guard let roomNo = roomNo else {return true}
                return roomNo.isEmpty
            }
            .bind(to: self.roomLabel.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.outputs.room
            .map {
                roomNo -> String in
                return ("Room # \(roomNo ?? "")")
            }
            .bind(to: self.roomLabel.rx.text)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(viewModel.outputs.appointmentDescription, viewModel.outputs.authorizedToViewTitleAppointments, viewModel.outputs.authorizedToViewTitleAndDescriptionAppointments).map{
            appointmentDescription, viewTitle, viewTitleAndDescription -> Bool in
            if viewTitle || viewTitleAndDescription {
                guard let appointmentDescription = appointmentDescription else {return true}
                return appointmentDescription.isEmpty
            } else {
               return true
            }
        }.bind(to: self.appointmentDescriptionLabel.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.outputs.appointmentDescription
            .bind(to: self.appointmentDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.outputs.staff
            .map { staff -> Bool in
                guard let staff = staff else {return true}
                return staff.isEmpty
            }
            .bind(to: self.staffLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.outputs.staff
            .bind(to: self.staffLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.outputs.profileImage
            .unwrap()
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
            .disposed(by: disposeBag)
        
        checkboxButton.rx.tap
            .bind(to: viewModel.inputs.markCheckbox)
            .disposed(by: disposeBag)
        
        viewModel.outputs.markPresent
            .subscribe(onNext: { [weak self] selected in
                guard let self = self else { return }
                if selected {
                    self.checkboxButton.setImage(UIImage.moduleImage(named: "icon_checkbox_selected"), for: .normal)
                }else{
                    self.checkboxButton.setImage(UIImage.moduleImage(named: "icon_checkbox_unselected"), for: .normal)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.markPresentEnabled
            .subscribe(onNext: { [weak self] selected in
                guard let self = self else { return }
                self.checkboxButton.rx.isEnabled.onNext(selected)
            })
            .disposed(by: disposeBag)
        
    }
    
}
