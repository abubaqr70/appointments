// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class AppointmentTableViewCell: RxUITableViewCell {
    
    fileprivate lazy var appointmentDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.appFont(withStyle: .title2, size: 15)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var staffLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.appGrayDark
        label.font = UIFont.appFont(withStyle: .title3, size: 15)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var checkboxButton : UIButton = {
        let checkboxButton = UIButton(frame: CGRect.zero)
        checkboxButton.backgroundColor = UIColor.white
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        checkboxButton.imageView?.contentMode = .scaleToFill
        checkboxButton.contentVerticalAlignment = .fill
        checkboxButton.contentHorizontalAlignment = .fill
        return checkboxButton
    }()
    
    fileprivate lazy var arrowImage : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.image = UIImage.moduleImage(named: "icon_date_right")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = UIColor.appGrayDark
        view.backgroundColor = UIColor.white
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
        cellView.addSubview(buttonAppointmentsView)
        buttonAppointmentsView.addSubview(checkboxButton)
        buttonAppointmentsView.addSubview(appointmentDescriptionLabel)
        buttonAppointmentsView.addSubview(staffLabel)
        buttonAppointmentsView.addSubview(arrowImage)
        contentView.backgroundColor = UIColor.appBackgroundGray
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            arrowImage.centerYAnchor.constraint(equalTo: buttonAppointmentsView.centerYAnchor),
            arrowImage.leadingAnchor.constraint(equalTo: staffLabel.trailingAnchor, constant: 10),
            arrowImage.trailingAnchor.constraint(equalTo: buttonAppointmentsView.trailingAnchor, constant: -10),
            arrowImage.widthAnchor.constraint(equalToConstant: 10),
            arrowImage.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        NSLayoutConstraint.activate([
            buttonAppointmentsView.topAnchor.constraint(equalTo: cellView.topAnchor),
            buttonAppointmentsView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20),
            buttonAppointmentsView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor,constant: -15),
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
            staffLabel.centerYAnchor.constraint(equalTo: buttonAppointmentsView.centerYAnchor),
            staffLabel.topAnchor.constraint(greaterThanOrEqualTo: buttonAppointmentsView.topAnchor,constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 0),
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
        
        
        
        viewModel.outputs.appointmentDescription
            .map{
                appointmentDescription -> Bool in
                guard let appointmentDescription = appointmentDescription else {return true}
                return appointmentDescription.isEmpty
            }
            .bind(to: self.appointmentDescriptionLabel.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.outputs.appointmentDescription
            .bind(to: self.appointmentDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(viewModel.outputs.staff, viewModel.outputs.authorizedToViewTitleAppointments, viewModel.outputs.authorizedToViewTitleAndDescriptionAppointments, viewModel.outputs.authorizedToManageAppointments).map{
            staff, viewTitle, viewTitleAndDescription, manageAppointments -> Bool in
            if manageAppointments {
                guard let staff = staff else {return true}
                return staff.isEmpty
            } else {
                if viewTitle || viewTitleAndDescription {
                    return true
                } else {
                    guard let staff = staff else {return true}
                    return staff.isEmpty
                }
            }
        }.bind(to: self.staffLabel.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.outputs.staff
            .bind(to: self.staffLabel.rx.text)
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
