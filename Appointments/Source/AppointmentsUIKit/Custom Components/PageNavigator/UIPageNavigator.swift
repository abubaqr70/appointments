//  Created by Hussaan Saeed on 23/10/2019.

import Foundation
import RxSwift
import RxCocoa

class UIPageNavigator: UIView {
    
    fileprivate lazy var nextButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.setImage(UIImage(named: "date-right", in: Bundle(for: UIPageNavigator.self), compatibleWith: .none), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var previousButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.setImage(UIImage(named: "date-left", in: Bundle(for: UIPageNavigator.self), compatibleWith: .none), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var titleButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.setTitleColor( UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.appFont(withStyle: .f300, size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var titleLable: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.appFont(withStyle: .f500, size: 18)
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousButton, titleButton, nextButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            nextButton.widthAnchor.constraint(equalToConstant: 44),
            previousButton.widthAnchor.constraint(equalToConstant: 44),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        
    }
}

extension Reactive where Base: UIPageNavigator {
    
    var next: ControlEvent<Void> { return self.base.nextButton.rx.tap }
    
    var previous: ControlEvent<Void> { return self.base.previousButton.rx.tap }
    
    var title: Binder<String?> { return self.base.titleLable.rx.text }
    
    var titleBtnTap: ControlEvent<Void> { return self.base.titleButton.rx.tap }
    
    var titleBtn: Binder<String?> { return self.base.titleButton.rx.title(for: .normal) }
    
    var nextEnable: Binder<Bool> { return self.base.nextButton.rx.isEnabled }
    
    var previousEnable: Binder<Bool> { return self.base.previousButton.rx.isEnabled }
    
    var titleBtnEnable: Binder<Bool> { return self.base.titleButton.rx.isEnabled }
    
}
