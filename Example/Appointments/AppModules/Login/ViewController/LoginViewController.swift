// Copyright © 2021 Caremerge. All rights reserved.

import UIKit
import RxSwift
import Alamofire

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var username: UnderlinedDesignableTextField!
    @IBOutlet weak var password: UnderlinedDesignableTextField!
    @IBOutlet weak var loginBtn: DesignableButton!
    
    let disposeBag = DisposeBag()
    private lazy var viewModel : LoginViewModelType = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindInputs(viewModel: viewModel)
        bindOutputs(viewModel: viewModel)
        bindButonTap(viewModel: viewModel)
        
    }
    
}
extension LoginViewController {
    func bindInputs(viewModel:LoginViewModelType){
        username.rx.text.map{$0 ?? ""}.bind(to: viewModel.inputs.usernameTextObserver ).disposed(by: disposeBag)
        password.rx.text.map{$0 ?? ""}.bind(to: viewModel.inputs.passwordTextObserver ).disposed(by: disposeBag)
    }
    
    func bindButonTap(viewModel:LoginViewModelType){
        self.loginBtn.rx.tap.asObservable()
            .withLatestFrom(viewModel.outputs.isLoginValidObservable)
            .map{
                value in
                return value
            }
            .bind(to: viewModel.inputs.loginTappedObserver)
            .disposed(by: disposeBag)
    }
    
    func bindOutputs(viewModel:LoginViewModelType){
        viewModel.outputs.isLoginValidObservable.bind(to: loginBtn.rx.isEnabled).disposed(by: disposeBag)
        viewModel.outputs.isLoginValidObservable.map{$0 ? 1: 0.5}.bind(to: loginBtn.rx.alpha).disposed(by: disposeBag)
        viewModel.outputs.loginSuccessObservable.subscribe(onNext: { [weak self]
            result in
            guard let self = self else {return}
            if result{
                self.changeRootViewController(identifier: "FacilityViewController")
            }else {
                Functions.showAlert(message: "You enter invalid credentials.")
            }
        }).disposed(by: disposeBag)
    }
    
}
