//
//  LoginViewController.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/12.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.id.bind { [weak self] text in
            print("Bind :", text)
            self?.idTextField.text = text
        }
        
        // 첫실행 시 isLogin가 false인 이유는 bind 구문이 실행되고 있지 않기 때문이다.
        viewModel.pwd.bind { [weak self] text in
            self?.pwdTextField.text = text
        }
        
        viewModel.isLogin.bind { [weak self] isLogin in
            self?.loginButton.isEnabled = isLogin
            self?.loginButton.backgroundColor = isLogin ? .green : .lightGray
        }
        
    
        loginButton.addTarget(self, action: #selector(didTappLoginButton), for: .touchUpInside)
        idTextField.addTarget(self, action: #selector(idTextFieldChanged), for: .editingChanged)
        pwdTextField.addTarget(self, action: #selector(pwdTextFieldChanged), for: .editingChanged)
    }
    
    @objc func idTextFieldChanged() {
        viewModel.id.value = idTextField.text!
        viewModel.checkValidation()
    }
    
    @objc func pwdTextFieldChanged() {
        viewModel.id.value = pwdTextField.text!
        viewModel.checkValidation()
    }
    
    @objc func didTappLoginButton() {
        print("로그인 성공했기 때문에 얼럿 띄우기")
        viewModel.signIn {
            print("얼럿")
        }
    }
}
