//
//  LoginViewController.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/12.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var idTextFieldd: UITextField!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var pwLabel: UILabel!
    
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.email.bind {  text in
            self.idTextFieldd.text = text
        }

        // 첫실행 시 isLogin가 false인 이유는 bind 구문이 실행되고 있지 않기 때문이다.
        viewModel.pwd.bind { [weak self] text in
            self?.pwdTextField.text = text
        }

        viewModel.code.bind { [weak self] text in
            self?.codeTextField.text = String(text ?? "")
        }
        
        viewModel.validEmail.bind { [weak self] bool in
            self?.idLabel.isHidden = bool
            self?.idLabel.backgroundColor = bool ? .green : .lightGray
        }
        
        viewModel.validPwd.bind { [weak self] bool in
            self?.pwLabel.isHidden = bool
            self?.pwLabel.backgroundColor = bool ? .green : .lightGray
        }
        
        viewModel.validCode.bind { [weak self] bool in
            self?.codeLabel.isHidden = bool
            self?.codeLabel.backgroundColor = bool ? .green : .lightGray
        }
                
        viewModel.isLogin.bind { [weak self] isLogin in
            self?.loginButton.isEnabled = isLogin
            self?.loginButton.backgroundColor = isLogin ? .green : .lightGray
        }
        
        
        loginButton.addTarget(self, action: #selector(didTappLoginButton), for: .touchUpInside)
        idTextFieldd.addTarget(self, action: #selector(idTextFieldChanged), for: .editingChanged)
        pwdTextField.addTarget(self, action: #selector(pwdTextFieldChanged), for: .editingChanged)
        codeTextField.addTarget(self, action: #selector(codeTextFieldChanged), for: .editingChanged)
    }
    
    @objc func idTextFieldChanged() {
        viewModel.email.value = idTextFieldd.text!
        viewModel.checkEmail()
        viewModel.checkisLogin()
    }
    
    @objc func pwdTextFieldChanged() {
        viewModel.pwd.value = pwdTextField.text!
        viewModel.checkPwdValidation()
        viewModel.checkisLogin()
    }
    
    @objc func codeTextFieldChanged() {
        viewModel.code.value = codeTextField.text!
        viewModel.checkCode()
        viewModel.checkisLogin()
    }
    
    @objc func didTappLoginButton() {
        print("로그인 성공했기 때문에 얼럿 띄우기")
        viewModel.signIn {
            print("얼럿")
        }
    }
}
