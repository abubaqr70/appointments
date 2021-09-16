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
        bind()
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
    
    private func bind() {
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
extension Reactive where Base: AppointmentTableViewCell {
    
    
    var appointments : Binder<Appointment >{
        return Binder(self.base) { cell, appointment in
            
            //Mark:- Setting Room Label
            if appointment.user?.v_room_no?.isEmpty ?? false {
                cell.room_label.isHidden = true
            } else {
                cell.room_label.isHidden = false
                cell.room_label.text = appointment.user?.v_room_no
            }
            
            //Mark:- Setting Description
            if appointment.v_title?.isEmpty ?? false {
                cell.appointment_description_label.isHidden = true
            } else {
                cell.appointment_description_label.isHidden = false
                cell.appointment_description_label.text = appointment.v_title
            }
            
            //Mark:- Setting Staff Label
            if appointment.user?.full_name?.isEmpty ?? false {
                cell.staff_label.isHidden = true
            } else {
                cell.staff_label.isHidden = false
                cell.staff_label.text = appointment.user?.full_name
            }
            
            //Mark:- Setting User Names
            var names:[String] = []
            if let users = appointment.appointmentAttendance {
                for user in users {
                    names.append(user.user?.fullname ?? "")
                }
            }
            
            if names.joined(separator: ", ").isEmpty{
                cell.name_label.isHidden = true
            } else {
                cell.name_label.isHidden = false
                cell.name_label.text = names.joined(separator: ", ")
            }
            
            
            //Mark:- Setting User Image
            guard let firstUser = appointment.appointmentAttendance?.first?.user else {return}
            cell.profile_image.kf.indicatorType = .activity
            cell.profile_image.kf.setImage(
                with: URL(string: firstUser.profileImageRoute ?? ""),
                placeholder: UIImage(named: "image_profile_placeholder"),
                options: [
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        }
    }
}
