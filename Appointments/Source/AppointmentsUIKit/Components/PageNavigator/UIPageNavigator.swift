// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxSwift
import RxCocoa

class UIPageNavigator: UIView {
    
    fileprivate lazy var nextButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.setImage(UIImage(named: "icon_date_right", in: Bundle(for: UIPageNavigator.self), compatibleWith: .none), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var previousButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.setImage(UIImage(named: "icon_date_left", in: Bundle(for: UIPageNavigator.self), compatibleWith: .none), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var titleTextField: UITextField = {
        let textField = UITextField(frame: CGRect.zero)
        textField.textColor = UIColor.darkGray
        textField.font = UIFont.appFont(withStyle: .title3, size: 15)
        textField.contentMode = .center
        textField.textAlignment = .center
        textField.borderStyle = .none
        textField.tintColor = .clear
        textField.inputView = date_picker
        textField.inputAccessoryView = tool_bar
        return textField
    }()
    
    fileprivate lazy var date_picker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.addTarget(self, action: #selector(dueDateChanged(sender:)), for: UIControl.Event.valueChanged)
        datePicker.frame = CGRect(x:0.0, y:0, width: self.frame.width, height:250)
        return datePicker
    }()
    
    fileprivate lazy var tool_bar : UIToolbar = {
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(self.tapCancel))
        toolBar.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 44)
        toolBar.setItems([cancelButton, UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        return toolBar
    }()
    
    
    fileprivate lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousButton, titleTextField, nextButton])
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
    
    @objc func dueDateChanged(sender:UIDatePicker){
        
    }
    
    @objc func datePickerDone() {
        titleTextField.resignFirstResponder()
        let dateFormatr = DateFormatter()
        dateFormatr.dateFormat = "EEEE, MMM dd, yyyy"
        
        date_picker.rx.date.map{ return dateFormatr.string(from: $0)}
            .bind(to: titleTextField.rx.text)
            .disposed(by: disposeBag)
        
        date_picker.rx.date
            .bind(to: dateSubject)
            .disposed(by: disposeBag)
    }
    
    @objc func tapCancel() {
        titleTextField.resignFirstResponder()
    }
    
    let dateSubject : BehaviorSubject = BehaviorSubject<Date>(value: Date())
}


extension Reactive where Base: UIPageNavigator {
    
    var next: ControlEvent<Void> { return self.base.nextButton.rx.tap }
    
    var previous: ControlEvent<Void> { return self.base.previousButton.rx.tap }
    
    var titleTextField: Binder<String?> { return self.base.titleTextField.rx.text }
    
    var nextEnable: Binder<Bool> { return self.base.nextButton.rx.isEnabled }
    
    var previousEnable: Binder<Bool> { return self.base.previousButton.rx.isEnabled }
    
}
