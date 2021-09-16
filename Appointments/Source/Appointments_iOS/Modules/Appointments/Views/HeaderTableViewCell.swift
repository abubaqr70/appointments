// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxCocoa
import RxSwift

class HeaderTableViewCell: RxUITableViewCell {
    
    fileprivate lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.appFont(withStyle: .title3, size: 12)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var cellView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "color_app_blue", in: Bundle(for: Self.self), compatibleWith: .none)
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
        contentView.addSubview(cellView)
        cellView.addSubview(headingLabel)
        contentView.backgroundColor = UIColor(named: "color_app_light_gray", in: Bundle(for: Self.self), compatibleWith: .none)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 5),
            headingLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20),
            headingLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20),
            headingLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellView.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -20)
        ])
        
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 6)
        bottomConstraint.priority = UILayoutPriority(999)
        bottomConstraint.isActive = true
    }
}

extension Reactive where Base: HeaderTableViewCell {
    
    var heading: Binder<String> {
        return Binder(self.base) { cell, heading in
            
            //Mark:- Setting Heading Title
            if  heading.isEmpty {
                cell.headingLabel.isHidden = true
                cell.cellView.isHidden = true
            } else {
                cell.headingLabel.isHidden = false
                cell.cellView.isHidden = false
                cell.headingLabel.text = heading
            }
            
        }
    }
}
