// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxCocoa
import RxSwift

class HeaderTableViewCell: RxUITableViewCell {
    
    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Random Name"
        label.font = UIFont.appFont(withStyle: .body, size: 16)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var roomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.appGrayDark
        label.text = "Random Room"
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
        view.backgroundColor = UIColor.appBackgroundGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var timeLabel: UILabel = {
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
        view.backgroundColor = UIColor.appLightSkyBlue
        view.layer.cornerRadius = 3
        return view
    }()
    
    private var viewModel: HeaderTVCellViewModelType?
    
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
        contentView.addSubview(imageNameView)
        cellView.addSubview(timeLabel)
        imageNameView.addSubview(profileImage)
        imageNameView.addSubview(nameStackView)
        contentView.backgroundColor = UIColor.appBackgroundGray
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            imageNameView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageNameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageNameView.trailingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: -20)
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
            timeLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20),
            timeLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20),
            timeLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            cellView.centerYAnchor.constraint(equalTo: imageNameView.centerYAnchor),
            cellView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
        
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: imageNameView.bottomAnchor, constant: 5)
        bottomConstraint.priority = UILayoutPriority(999)
        bottomConstraint.isActive = true
    }
}

extension HeaderTableViewCell {
    
    override func configure(viewModel: Any) {
        guard let viewModel = viewModel as? HeaderTVCellViewModelType else { return }
        self.viewModel = viewModel
        bind(viewModel: viewModel)
    }
    
    private func bind(viewModel : HeaderTVCellViewModelType) {
        
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
            self.profileImage.kf.indicatorType = .activity
            self.profileImage.kf.setImage(
                with: URL(string: urlImage ?? ""),
                placeholder: UIImage.moduleImage(named: "image_profile_placeholder"),
                options: [
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        }).disposed(by: disposeBag)
        
        viewModel.outputs.time
            .bind(to: self.timeLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.outputs.time.map{
            time -> Bool in
            return time?.isEmpty ?? false
        }.bind(to: cellView.rx.isHidden).disposed(by: disposeBag)
        
    }
    
}
