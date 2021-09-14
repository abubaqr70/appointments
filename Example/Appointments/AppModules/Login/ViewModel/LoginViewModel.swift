// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

protocol LoginViewModelInputs {
    var usernameTextObserver : AnyObserver<String>{get}
    var passwordTextObserver : AnyObserver<String>{get}
    var loginTappedObserver : AnyObserver<Bool>{get}
}

protocol LoginViewModelOutputs {
    var isLoginValidObservable : Observable<Bool>{get}
    var loginSuccessObservable : Observable<Bool>{get}
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

class LoginViewModel : LoginViewModelType,LoginViewModelInputs,LoginViewModelOutputs{
    
    private var context : UIViewController?
    
    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }
    //Mark:- Inputs
    var usernameTextObserver: AnyObserver<String>{ return username.asObserver()}
    var passwordTextObserver: AnyObserver<String>{ return passwordText.asObserver()}
    var loginTappedObserver: AnyObserver<Bool>{ return loginTapped.asObserver()}
    
    //Mark:- Outputs
    var isLoginValidObservable: Observable<Bool>{ return isLoginValid.asObservable()}
    var loginSuccessObservable: Observable<Bool>{ return loginSuccess.asObservable()}
    
    //Mark:- Private Properties
    private var disposeBag = DisposeBag()
    private var username = BehaviorSubject<String>(value: "")
    private var passwordText = BehaviorSubject<String>(value: "")
    private var isLoginValid = BehaviorSubject<Bool>(value: false)
    private var loginSuccess = BehaviorSubject<Bool>(value: false)
    private let loginTapped = BehaviorSubject<Bool>(value: false)
    private var accountDetail = Dictionary<String,String>()
    
    init() {
        
        Observable.combineLatest(username.asObservable(), passwordText.asObservable()).map{ [weak self]
            email, password in
            print(email,password)
            return (email.count > 0) && ((self?.validateLength(text: password, size: (6,12))) ?? false)
        }
        .bind(to: isLoginValid)
        .disposed(by: self.disposeBag)
        
        loginTapped.subscribe(onNext: {
            value in
            if value {
                Functions.showActivity()
                self.userLogin()
            }
        }).disposed(by: disposeBag)
        
    }
    
    func getParams() -> [String:Any]{
        let email = try? self.username.value()
        let password = try? self.passwordText.value()
        let params = ["username": email,"password": password]
        return params as [String : Any]
    }
    
    func userLogin(){
        ApiManager.postRequest(with: APPURL.Login, parameters: getParams(), completion: { (result) in
            Functions.hideActivity()
            switch result {
            case .success(let result):
                if #available(iOS 13.0, *) {
                    print("response headers",result.response?.value(forHTTPHeaderField: "x-care-merge-api-token") as Any)
                    UserDefaults.standard.setValue(result.response?.value(forHTTPHeaderField: "x-care-merge-api-token"), forKey: "api_key")
                } else {
                    // Fallback on earlier versions
                    print("response headers",result.response?.allHeaderFields["x-care-merge-api-token"] as Any)
                    UserDefaults.standard.setValue(result.response?.allHeaderFields["x-care-merge-api-token"], forKey: "api_key")
                }
                let newjson = try? JSONSerialization.data(withJSONObject: result.value as Any, options: .prettyPrinted)
                Functions.saveJSON(json: newjson ?? Data(), key: "user_detail")
                self.loginSuccess.onNext(true)
            case .failure(let error):
                self.loginSuccess.onNext(false)
                print(error)
            }
        })
    }
    
    func validateLength(text : String, size : (min : Int, max : Int)) -> Bool{
        return (size.min...size.max).contains(text.count)
    }
    
}

