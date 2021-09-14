// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func clearNavigation(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    
    func changeRootViewController(identifier: String){
        let viewController = Storyboard.Main.instantiateViewController(withIdentifier: identifier)
        let nav1 = UINavigationController()
        nav1.viewControllers = [viewController]
        nav1.navigationBar.tintColor = .white
        nav1.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIApplication.shared.windows.first?.rootViewController = nav1
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func changeRootViewControllerWithoutNav(identifier: String){
        let viewController = Storyboard.Main.instantiateViewController(withIdentifier: identifier)
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func addLogoutBtn(){
        let logoutImage    = UIImage(named: "logout")!
        let logoutButton   = UIBarButtonItem(image: logoutImage,  style: .plain, target: self, action: #selector(didTapLogoutButton(_:)))
        logoutButton.imageInsets = UIEdgeInsets(top: 0.0, left: 10, bottom: 0, right: 10)
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc func didTapLogoutButton(_ sender: UIBarButtonItem){
        let refreshAlert = UIAlertController(title: "POCIOS DEMO", message: "Are you sure you want to logout?", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            self.logout()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    func logout(){
        UserDefaults.standard.setValue(nil, forKey: "api_key")
        Functions.removeJson(key: "user_detail")
        Functions.removeJson(key: "facilities")
        changeRootViewControllerWithoutNav(identifier: "LoginViewController")
    }
}
