// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxCocoa
import RxSwift

class HeaderTableViewCell: RxUITableViewCell {
    
    fileprivate lazy var heading_label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.appFont(withStyle: .title3, size: 12)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var cell_view : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "color_app_blue", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none)
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
        contentView.addSubview(cell_view)
        cell_view.addSubview(heading_label)
        contentView.backgroundColor = UIColor(named: "color_app_light_gray", in: Bundle(for: AppointmentsViewController.self), compatibleWith: .none)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            heading_label.topAnchor.constraint(equalTo: cell_view.topAnchor, constant: 5),
            heading_label.leadingAnchor.constraint(equalTo: cell_view.leadingAnchor, constant: 20),
            heading_label.trailingAnchor.constraint(equalTo: cell_view.trailingAnchor, constant: -20),
            heading_label.bottomAnchor.constraint(equalTo: cell_view.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            cell_view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            cell_view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cell_view.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -20)
        ])

        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: cell_view.bottomAnchor, constant: 6)
        bottomConstraint.priority = UILayoutPriority(999)
        bottomConstraint.isActive = true
    }
}

extension Reactive where Base: HeaderTableViewCell {
    
    var heading: Binder<NSAttributedString> {
        return Binder(self.base) { cell, heading in
            cell.heading_label.attributedText = heading
        }
    }
}
