// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import UIKit
import SVProgressHUD

enum ToastType {
    case success
    case failure
    case warning
}

class Functions: NSObject {
    
    
    class func saveJSON(json: Data, key:String){
        UserDefaults.standard.setValue(json, forKey: key)
    }
    
    class func removeJson(key:String){
        UserDefaults.standard.setValue(nil, forKey: key)
    }
    
    class func getJSON(_ key: String)-> Data? {
        if let result = UserDefaults.standard.data(forKey: key) {
            return result
        }else {
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

    
    static func showAlert(message : String){
        let alert = UIAlertController(title: "POCIOS", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
}


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
