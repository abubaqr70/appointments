// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class AppointmentTableViewCell: RxUITableViewCell {
    
    fileprivate lazy var name_label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Nathaniel Jones"
        label.font = UIFont.appFont(withStyle: .body, size: 16)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var room_label: UILabel = {
        let label = UILabel()
        label.text = "Room #101"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "color_app_dark_gray", in: Bundle(for: AppointmentTableViewCell.self), compatibleWith: .none)
        label.font = UIFont.appFont(withStyle: .title3, size: 14)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var appointment_description_label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Usman's appointment with Barney"
        label.textColor = .black
        label.font = UIFont.appFont(withStyle: .title3, size: 14)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var staff_label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "color_app_dark_gray", in: Bundle(for: AppointmentTableViewCell.self), compatibleWith: .none)
        label.text = "Staff"
        label.font = UIFont.appFont(withStyle: .title3, size: 14)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var profile_image : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.image = UIImage(named: "image_profile_placeholder", in: Bundle(for: AppointmentTableViewCell.self), compatibleWith: .none)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    fileprivate lazy var checkbox_button : UIButton = {
        let checkbox_button = UIButton(frame: CGRect.zero)
        checkbox_button.backgroundColor = UIColor.white
        checkbox_button.translatesAutoresizingMaskIntoConstraints = false
        checkbox_button.setImage(UIImage(named: "icon_checkbox_unselected", in: Bundle(for: AppointmentTableViewCell.self), compatibleWith: .none), for: .normal)
        checkbox_button.setImage(UIImage(named: "icon_checkbox_selected", in: Bundle(for: AppointmentTableViewCell.self), compatibleWith: .none), for: .selected)
        checkbox_button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return checkbox_button
    }()
    
    fileprivate lazy var arrow_image : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.image = UIImage(named: "icon_date_right", in: Bundle(for: AppointmentTableViewCell.self), compatibleWith: .none)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var line_view : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor(named: "color_app_light_gray", in: Bundle(for: AppointmentTableViewCell.self), compatibleWith: .none)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var cell_view : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()
    
    fileprivate lazy var names_stack_view: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [name_label, room_label])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    fileprivate lazy var image_name_view : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var button_appointments_view : UIView = {
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
        contentView.addSubview(cell_view)
        cell_view.addSubview(image_name_view)
        cell_view.addSubview(line_view)
        cell_view.addSubview(button_appointments_view)
        image_name_view.addSubview(profile_image)
        image_name_view.addSubview(names_stack_view)
        image_name_view.addSubview(arrow_image)
        button_appointments_view.addSubview(checkbox_button)
        button_appointments_view.addSubview(appointment_description_label)
        button_appointments_view.addSubview(staff_label)
        contentView.backgroundColor = UIColor(named: "color_app_light_gray", in: Bundle(for: AppointmentTableViewCell.self), compatibleWith: .none)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            image_name_view.topAnchor.constraint(equalTo: cell_view.topAnchor, constant: 10),
            image_name_view.leadingAnchor.constraint(equalTo: cell_view.leadingAnchor, constant: 10),
            image_name_view.trailingAnchor.constraint(equalTo: cell_view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            profile_image.leadingAnchor.constraint(equalTo: image_name_view.leadingAnchor),
            profile_image.centerYAnchor.constraint(equalTo: image_name_view.centerYAnchor),
            profile_image.topAnchor.constraint(greaterThanOrEqualTo: image_name_view.topAnchor),
            profile_image.bottomAnchor.constraint(greaterThanOrEqualTo: image_name_view.bottomAnchor, constant: -5),
            profile_image.widthAnchor.constraint(equalToConstant: 40),
            profile_image.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            names_stack_view.topAnchor.constraint(greaterThanOrEqualTo: image_name_view.topAnchor, constant: 5),
            names_stack_view.bottomAnchor.constraint(greaterThanOrEqualTo: image_name_view.bottomAnchor, constant: -5),
            names_stack_view.centerYAnchor.constraint(equalTo: image_name_view.centerYAnchor),
            names_stack_view.leadingAnchor.constraint(equalTo: profile_image.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            arrow_image.centerYAnchor.constraint(equalTo: image_name_view.centerYAnchor),
            arrow_image.leadingAnchor.constraint(equalTo: names_stack_view.trailingAnchor, constant: 10),
            arrow_image.trailingAnchor.constraint(equalTo: image_name_view.trailingAnchor, constant: -10),
            arrow_image.widthAnchor.constraint(equalToConstant: 10),
            arrow_image.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        NSLayoutConstraint.activate([
            line_view.topAnchor.constraint(equalTo: image_name_view.bottomAnchor,constant: 5),
            line_view.leadingAnchor.constraint(equalTo: cell_view.leadingAnchor, constant: 60),
            line_view.trailingAnchor.constraint(equalTo: cell_view.trailingAnchor),
            line_view.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            button_appointments_view.topAnchor.constraint(equalTo: line_view.bottomAnchor),
            button_appointments_view.leadingAnchor.constraint(equalTo: cell_view.leadingAnchor, constant: 10),
            button_appointments_view.trailingAnchor.constraint(equalTo: cell_view.trailingAnchor,constant: -10),
            button_appointments_view.bottomAnchor.constraint(equalTo: cell_view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            checkbox_button.leadingAnchor.constraint(equalTo: button_appointments_view.leadingAnchor),
            checkbox_button.centerYAnchor.constraint(equalTo: button_appointments_view.centerYAnchor),
            checkbox_button.topAnchor.constraint(greaterThanOrEqualTo: button_appointments_view.topAnchor,constant: 10),
            checkbox_button.heightAnchor.constraint(equalToConstant: 40),
            checkbox_button.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            appointment_description_label.leadingAnchor.constraint(equalTo: checkbox_button.trailingAnchor),
            appointment_description_label.centerYAnchor.constraint(equalTo: button_appointments_view.centerYAnchor),
            appointment_description_label.topAnchor.constraint(greaterThanOrEqualTo: button_appointments_view.topAnchor, constant: 5),
            appointment_description_label.bottomAnchor.constraint(greaterThanOrEqualTo: button_appointments_view.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            staff_label.leadingAnchor.constraint(greaterThanOrEqualTo: appointment_description_label.trailingAnchor,constant: 10),
            staff_label.trailingAnchor.constraint(equalTo: button_appointments_view.trailingAnchor,constant: -10),
            staff_label.centerYAnchor.constraint(equalTo: button_appointments_view.centerYAnchor),
            staff_label.topAnchor.constraint(greaterThanOrEqualTo: button_appointments_view.topAnchor,constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            cell_view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            cell_view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cell_view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            cell_view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
        ])
        
        appointment_description_label.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        appointment_description_label.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        
        appointment_description_label.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        appointment_description_label.setContentCompressionResistancePriority(.defaultLow + 1, for: .horizontal)
        
    }
    
    override func configure(viewModel: Any) {
        guard let viewModel = viewModel as? AppointmentTVCellViewModelType else { return }
        self.viewModel = viewModel
        bind(viewModel: viewModel)
    }
    
    private func bind(viewModel : AppointmentTVCellViewModelType) {
        
        viewModel.outputs.nameObservable.map { name -> Bool in
            guard let name = name else {return true}
            return name.isEmpty
        }.bind(to: self.name_label.rx.isHidden).disposed(by: disposeBag)
        viewModel.outputs.nameObservable.bind(to: self.name_label.rx.text).disposed(by: disposeBag)
        
        viewModel.outputs.roomObservable.map { roomNo -> Bool in
            guard let roomNo = roomNo else {return true}
            return roomNo.isEmpty
        }.bind(to: self.room_label.rx.isHidden).disposed(by: disposeBag)
        viewModel.outputs.roomObservable.map{
            roomNo -> String in
            return ("Room # \(roomNo ?? "")")
        }
        .bind(to: self.room_label.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.outputs.appointmentDescriptionObservable.map { description -> Bool in
            guard let description = description else {return true}
            return description.isEmpty
        }.bind(to: self.appointment_description_label.rx.isHidden).disposed(by: disposeBag)
        viewModel.outputs.appointmentDescriptionObservable.bind(to: self.appointment_description_label.rx.text).disposed(by: disposeBag)
        
        viewModel.outputs.staffObservable.map { staff -> Bool in
            guard let staff = staff else {return true}
            return staff.isEmpty
        }.bind(to: self.staff_label.rx.isHidden).disposed(by: disposeBag)
        viewModel.outputs.staffObservable.bind(to: self.staff_label.rx.text).disposed(by: disposeBag)
        
        viewModel.outputs.profileImageObservable.map({
            profileUrl in
            self.profile_image.kf.indicatorType = .activity
            self.profile_image.kf.setImage(
                with: URL(string: profileUrl ?? ""),
                placeholder: UIImage(named: "image_profile_placeholder"),
                options: [
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        })
        .subscribe()
        .disposed(by: disposeBag)
        
        checkbox_button.rx.tap
            .bind {
                if !self.checkbox_button.isSelected{
                    self.checkbox_button.isSelected = true
                }else{
                    self.checkbox_button.isSelected = false
                }
                print("checkbox_button tapped")
            }
            .disposed(by: disposeBag)
    }
    
}
