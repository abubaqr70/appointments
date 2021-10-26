// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxCocoa
import RxSwift

class FilterHeaderTableViewCell: RxUITableViewCell {
    
    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "All Staff"
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var checkboxButton : UIButton = {
        let checkboxButton = UIButton(frame: CGRect.zero)
        checkboxButton.backgroundColor = UIColor.white
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.imageView?.contentMode = .scaleToFill
        checkboxButton.contentVerticalAlignment = .fill
        checkboxButton.contentHorizontalAlignment = .fill
        checkboxButton.setImage(UIImage.moduleImage(named: "icon_checkbox_unselected"), for: .normal)
        checkboxButton.backgroundColor = .clear
        return checkboxButton
    }()
    
    fileprivate lazy var lineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.appGrayLight
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var cellView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.appGrayLight
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var viewModel: FilterHeaderTVCellViewModel?
    
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
        cellView.addSubview(nameLabel)
        cellView.addSubview(checkboxButton)
        cellView.addSubview(lineView)
        contentView.backgroundColor = UIColor.appGrayLight
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            checkboxButton.leadingAnchor.constraint(equalTo: cellView.leadingAnchor,constant: 10),
            checkboxButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            checkboxButton.widthAnchor.constraint(equalToConstant: 40),
            checkboxButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            nameLabel.topAnchor.constraint(greaterThanOrEqualTo: cellView.topAnchor,constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(greaterThanOrEqualTo: nameLabel.bottomAnchor, constant: -15),
            lineView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.8),
            lineView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
        ])
        
        
    }
    
}

extension FilterHeaderTableViewCell {
    
    override func configure(viewModel: Any) {
        guard let viewModel = viewModel as? FilterHeaderTVCellViewModel else { return }
        self.viewModel = viewModel
        bind(viewModel: viewModel)
    }
    
    
    private func bind(viewModel : FilterHeaderTVCellViewModel) {
        
        viewModel.outputs.headerTitle
            .map { name -> Bool in
                guard let name = name else {return true}
                return name.isEmpty
            }
            .bind(to: self.nameLabel.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.outputs.headerTitle
            .subscribe(onNext: {
                headerTitle in
                if headerTitle == "All Categories" {
                    self.cellView.backgroundColor = .white
                    self.checkboxButton.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                    self.nameLabel.font = UIFont.appFont(withStyle: .body, size: 16)
                } else {
                    self.cellView.backgroundColor = UIColor.appGrayLight
                    self.checkboxButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
                    self.nameLabel.font = UIFont.appFont(withStyle: .subhead, size: 16)
                }
                self.nameLabel.rx.text.onNext(headerTitle)
            })
            .disposed(by: disposeBag)
        
        checkboxButton.rx.tap
            .bind(to: viewModel.inputs.markCheckbox)
            .disposed(by: disposeBag)
        
        viewModel.outputs.checkFilter
            .subscribe(onNext: { [weak self] selected in
                guard let self = self else { return }
                if selected {
                    self.checkboxButton.setImage(UIImage.moduleImage(named: "icon_checkbox_selected"), for: .normal)
                }else{
                    self.checkboxButton.setImage(UIImage.moduleImage(named: "icon_checkbox_unselected"), for: .normal)
                }
            })
            .disposed(by: disposeBag)
        
    }
    
}
