//
//  AppoitmentsListCell.swift
//  Appointments
//
//  Created by Muhammad Abubaqr on 26/08/2021.
//

import UIKit
import RxCocoa
import RxSwift

class AppoitmentsListCell: RxUITableViewCell {
    
    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Nathaniel Jones"
        label.font = UIFont.appFont(withStyle: .f500, size: 16)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var roomLabel: UILabel = {
        let label = UILabel()
        label.text = "Room #101"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "appDarkGray", in: Bundle(for: AppoitmentsListCell.self), compatibleWith: .none)
        label.font = UIFont.appFont(withStyle: .f300, size: 14)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var appointmentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Usman's appointment with Barney"
        label.textColor = .black
        label.font = UIFont.appFont(withStyle: .f300, size: 14)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var staffLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "appDarkGray", in: Bundle(for: AppoitmentsListCell.self), compatibleWith: .none)
        label.text = "Staff"
        label.font = UIFont.appFont(withStyle: .f300, size: 14)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var profileImage : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.image = UIImage(named: "profile", in: Bundle(for: AppoitmentsListCell.self), compatibleWith: .none)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    fileprivate lazy var button : UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "chkbox_unsel", in: Bundle(for: AppoitmentsListCell.self), compatibleWith: .none), for: .normal)
        button.setImage(UIImage(named: "check-blue", in: Bundle(for: AppoitmentsListCell.self), compatibleWith: .none), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()
    
    fileprivate lazy var arrowImage : UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.image = UIImage(named: "date-right", in: Bundle(for: AppoitmentsListCell.self), compatibleWith: .none)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var lineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor(named: "appLightGray", in: Bundle(for: AppoitmentsListCell.self), compatibleWith: .none)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var view : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
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
    
    fileprivate lazy var topView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var bottomView : UIView = {
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
        contentView.addSubview(view)
        view.addSubview(topView)
        view.addSubview(lineView)
        view.addSubview(bottomView)
        topView.addSubview(profileImage)
        topView.addSubview(namesStackView)
        topView.addSubview(arrowImage)
        bottomView.addSubview(button)
        bottomView.addSubview(appointmentLabel)
        bottomView.addSubview(staffLabel)
        contentView.backgroundColor = UIColor(named: "appLightGray", in: Bundle(for: AppoitmentsListCell.self), compatibleWith: .none)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            profileImage.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
//            profileImage.topAnchor.constraint(greaterThanOrEqualTo: topView.topAnchor),
//            profileImage.bottomAnchor.constraint(greaterThanOrEqualTo: topView.bottomAnchor, constant: -5),
            profileImage.widthAnchor.constraint(equalToConstant: 40),
            profileImage.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            namesStackView.topAnchor.constraint(greaterThanOrEqualTo: topView.topAnchor, constant: 5),
            namesStackView.bottomAnchor.constraint(greaterThanOrEqualTo: topView.bottomAnchor, constant: -5),
            namesStackView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            namesStackView.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            arrowImage.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            arrowImage.leadingAnchor.constraint(equalTo: namesStackView.trailingAnchor, constant: 10),
            arrowImage.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10),
            arrowImage.widthAnchor.constraint(equalToConstant: 10),
            arrowImage.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: topView.bottomAnchor,constant: 5),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])

        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            button.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            button.topAnchor.constraint(greaterThanOrEqualTo: bottomView.topAnchor,constant: 10),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            appointmentLabel.leadingAnchor.constraint(equalTo: button.trailingAnchor),
            appointmentLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            appointmentLabel.topAnchor.constraint(greaterThanOrEqualTo: bottomView.topAnchor, constant: 5),
            appointmentLabel.bottomAnchor.constraint(greaterThanOrEqualTo: bottomView.bottomAnchor, constant: -5)
        ])

        NSLayoutConstraint.activate([
            staffLabel.leadingAnchor.constraint(greaterThanOrEqualTo: appointmentLabel.trailingAnchor,constant: 10),
            staffLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor,constant: -10),
            staffLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            staffLabel.topAnchor.constraint(greaterThanOrEqualTo: bottomView.topAnchor,constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
        ])
        
        appointmentLabel.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        appointmentLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        
        appointmentLabel.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        appointmentLabel.setContentCompressionResistancePriority(.defaultLow + 1, for: .horizontal)

    }
    
    private func bind() {
        button.rx.tap
            .bind {
                if !self.button.isSelected{
                    self.button.isSelected = true
                }else{
                    self.button.isSelected = false
                }
                print("button tapped")
            }
            .disposed(by: disposeBag)
    }
    
}
