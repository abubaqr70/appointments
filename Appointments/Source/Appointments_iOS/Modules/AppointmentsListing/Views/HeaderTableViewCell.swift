//
//  HeaderTableViewCell.swift
//  Appointments
//
//  Created by Muhammad Abubaqr on 26/08/2021.
//

import UIKit
import RxCocoa
import RxSwift

class HeaderTableViewCell: RxUITableViewCell {
    
    lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.appFont(withStyle: .f300, size: 12)
        label.numberOfLines = 4
        return label
    }()
    
    lazy var view : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "appBlue", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none)
        view.layer.cornerRadius = 3
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
    }
    
    private func setupViews() {
        selectionStyle = .none
        contentView.addSubview(view)
        view.addSubview(headingLabel)
        contentView.backgroundColor = UIColor(named: "appLightGray", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            headingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headingLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            view.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -20)
        ])

        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 6)
        bottomConstraint.priority = UILayoutPriority(999)
        bottomConstraint.isActive = true
    }
}

extension Reactive where Base: HeaderTableViewCell {
    
    var heading: Binder<NSAttributedString> {
        return Binder(self.base) { cell, heading in
            cell.headingLabel.attributedText = heading
        }
    }
}
