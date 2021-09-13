// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import JVFloatLabeledTextField

@IBDesignable public class DesignableButton: UIButton {
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable public var shadowColor: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable public var shadowOpacity: CGFloat = 0 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    
    @IBInspectable public var shadowOffsetY: CGFloat = 0 {
        didSet {
            layer.shadowOffset.height = shadowOffsetY
        }
    }
    
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

@IBDesignable public class UnderlinedDesignableTextField: JVFloatLabeledTextField , UITextFieldDelegate {
    
    let border = CALayer()
    private var __maxLengths = [UITextField: Int]()
    
    @IBInspectable open var lineColor : UIColor = UIColor.black {
        didSet{
            border.borderColor = lineColor.cgColor
        }
    }
    
    @IBInspectable open var selectedLineColor : UIColor = UIColor.black {
        didSet{
        }
    }
    
    @IBInspectable open var rightTextpadding : CGFloat = 0 {
        didSet{
        }
    }
    
    @IBInspectable open var leftTextpadding : CGFloat = 0 {
        didSet{
        }
    }
    
    @IBInspectable open var rightImagepadding : CGFloat = 0 {
        didSet{
        }
    }
    
    @IBInspectable open var leftImagepadding : CGFloat = 0 {
        didSet{
        }
    }
    
    @IBInspectable open var secureTextButtonHeight : CGFloat = 0 {
        didSet{
        }
    }
    
    @IBInspectable open var secureTextButtonWidth : CGFloat = 0 {
        didSet{
        }
    }
    
    
    @IBInspectable open var RightImageHeight : CGFloat = 0 {
        didSet{
        }
    }
    
    @IBInspectable open var RightImageWidth : CGFloat = 0 {
        didSet{
        }
    }
    
    @IBInspectable open var LeftImageHeight : CGFloat = 0 {
        didSet{
        }
    }
    
    @IBInspectable open var LeftImageWidth : CGFloat = 0 {
        didSet{
        }
    }
    
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
    
    @IBInspectable var rightPadding: Bool = false {
        didSet {
            setRightPaddingPoints(rightTextpadding)
        }
    }
    
    @IBInspectable var enableSecureButton: Bool = false {
        didSet {
            self.enablePasswordToggle()
        }
    }
    @IBInspectable var leftPadding: Bool = false {
        didSet {
            setLeftPaddingPoints(leftTextpadding)
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            setRightImage()
        }
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            setleftImage()
        }
    }
    
    @IBInspectable open var lineHeight : CGFloat = CGFloat(1.0) {
        didSet{
            border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
        }
    }
    
    required init?(coder aDecoder: (NSCoder?)) {
        super.init(coder: aDecoder!)
        self.delegate=self;
        border.borderColor = lineColor.cgColor
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = lineHeight
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    public override func draw(_ rect: CGRect) {
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
        self.delegate = self
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        border.borderColor = selectedLineColor.cgColor
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        border.borderColor = lineColor.cgColor
    }
    
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.setImage(UIImage(named: "passwordShow"), for: .normal)
        }else{
            button.setImage(UIImage(named: "passwordHide"), for: .normal)
            
        }
    }
    
    
    public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
            var textRect = super.leftViewRect(forBounds: bounds)
            textRect.origin.x += leftImagepadding
            return textRect
        }
    
    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
            var textRect = super.rightViewRect(forBounds: bounds)
            textRect.origin.x -= rightImagepadding
            return textRect
        }
    
    func setRightImage(){
        if let image = rightImage {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: RightImageWidth, height: RightImageHeight))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            self.rightView = imageView
            self.rightViewMode = .always
        }
    }
    
    func setleftImage(){
        if let image = leftImage {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: LeftImageWidth, height: LeftImageHeight))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            self.leftView = imageView
            self.leftViewMode = .always
        }
    }
    
    
    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.frame = CGRect(x: 0, y: 0, width: secureTextButtonWidth, height: secureTextButtonHeight)
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    
    @IBAction func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
    
}

