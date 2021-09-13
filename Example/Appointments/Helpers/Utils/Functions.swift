// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import UIKit
import Toast_Swift
import SVProgressHUD
import SwiftyJSON
import SafariServices
import SwiftMessages



enum ToastType {
    case success
    case failure
    case warning
}

class Functions: NSObject {
    
    
    class func saveJSON(json: JSON, key:String){
        if let jsonString = json.rawString() {
            UserDefaults.standard.setValue(jsonString, forKey: key)
        }
    }
    
    class func removeJson(key:String){
            UserDefaults.standard.setValue(nil, forKey: key)
    }
    
    class func getJSON(_ key: String)-> JSON? {
        var p = ""
        if let result = UserDefaults.standard.string(forKey: key) {
            p = result
        }
        if p != "" {
            if let json = p.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                do {
                    return try JSON(data: json)
                } catch {
                    return nil
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func whereIsMySQLite() {
        let path = FileManager
            .default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .last?
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
            .removingPercentEncoding
        
        print(path ?? "Not found")
    }
    
    static func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }

    static func showToast(message:String,type:ToastType = .warning,duration:Double = 2.0 ,position:ToastPosition = .center){
        if !Thread.isMainThread { //run only from main thread
            DispatchQueue.main.async {
                Functions.showToast(message: message, type: type, duration: duration, position: position)
            }
            
            return
        }
        
        var style = ToastStyle()
        // this is just one of many style options
        //style.messageColor = .blue
        
        if type == .success{
            style.backgroundColor = UIColor(named: "GreenColour") ?? .green
        }else if type == .failure{
            style.backgroundColor = .systemRed
        }else if type == .warning{
            style.backgroundColor = .systemBlue
            
        }
        //ToastManager.shared.style = style
        
        
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.hideAllToasts()
        
        // window.makeToast(message, duration: duration, position: position)
        
        window.makeToast(message, duration: duration, position: position, title: nil, image: nil, style: style) { (didTap) in
            if didTap {
                window.hideAllToasts()
            } else {
                print("completion without tap")
            }
            
        }
        
        
    }
    static func showActivity(progres:Double = 0.0){
        if progres == 0.0{
            SVProgressHUD.show()
            SVProgressHUD.setDefaultMaskType(.clear)
            
        }else{
            let value = progres*100
            SVProgressHUD.showProgress(Float(progres), status: String(format: "%.1f percent", value))
            SVProgressHUD.setBackgroundColor(.lightGray)
        }
    }
    
    static func hideActivity(){
        SVProgressHUD.dismiss()
    }
   
    static func noInternetConnection(status:Bool){
        
        if status == true{
            SwiftMessages.hideAll()
            SwiftMessages.pauseBetweenMessages = 0.0
            
            let view: MessageView
            view = try! SwiftMessages.viewFromNib()
            
            view.configureContent(title: "", body: "Please check your internet connection", iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "", buttonTapHandler: { _ in
                
                SwiftMessages.hide()
                
            })
            view.accessibilityPrefix = "error"
            view.configureDropShadow()
            view.button?.isHidden = true
            
            var config = SwiftMessages.defaultConfig
            config.presentationStyle = .top
            config.presentationContext = .window(windowLevel: .statusBar)
            config.preferredStatusBarStyle = .lightContent
            config.interactiveHide = false
            config.duration = .forever
            view.configureTheme(backgroundColor: UIColor.red, foregroundColor: UIColor.white, iconImage: nil, iconText: nil)
            
            config.dimMode = .gray(interactive: true)
            SwiftMessages.show(config: config, view: view)
            
        }else{
            SwiftMessages.hide()
            SwiftMessages.hideAll()
            SwiftMessages.pauseBetweenMessages = 0.0
        }
        
    }

}


