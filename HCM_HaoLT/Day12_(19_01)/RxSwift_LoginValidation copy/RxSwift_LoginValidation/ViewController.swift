//
//  ViewController.swift
//  RxSwift_LoginValidation
//
//  Created by Hao Lam on 1/19/22.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var username_txt: UITextField!
    @IBOutlet weak var password_txt: UITextField!
    
    @IBOutlet weak var login_bttn: UIButton!
    
    @IBAction func login_didTapped(_ sender: UIButton) {
        print("Login button tapped!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        username_txt.becomeFirstResponder() ///show keyboard on username when screen launch
        
        username_txt.rx.text
            .map{ $0 ?? ""}
            .bind(to: loginViewModel.usernameSubject)
            .disposed(by: disposeBag)
        
        password_txt.rx.text
            .map{ $0 ?? ""}
            .bind(to: loginViewModel.passwordSubject)
            .disposed(by: disposeBag)

        ///NOTE:
        /// ** Any text that entered to username/password,  it will trigger combineLatest
        /// and return a bool  to tell us whether we should enable our login button
        ///
        loginViewModel.isValid()
            .bind(to: login_bttn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        /// change button color's tone
        loginViewModel.isValid()
            .map{ $0 ? 1 : 0.5}
            .bind(to: login_bttn.rx.alpha)
            .disposed(by: disposeBag)
        
    }


}

class LoginViewModel {
    //create a binding between inputs & view model
    //create aother binding between view model to inputs to confirm valid inputs
    
    //create 2 subjects for username & password
    let usernameSubject = PublishSubject<String>()
    let passwordSubject = PublishSubject<String>()
    
    
    //create an observable tell us when username + password are both valid
    func isValid() -> Observable<Bool> {
        return Observable
        
            .combineLatest(usernameSubject.asObservable().startWith(""),
                           passwordSubject.asObservable().startWith(""))
            .map { username, password in
                return username.count > 3 && password.count > 3
            }
            ///we start with false as we know it will not be empty at the beginning
            .startWith(false)
    }
    
    
    
    
}
