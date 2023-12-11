//
//  LoginUpdateViewController.swift
//  SeSACTest
//
//  Created by 김규철 on 2023/12/11.
//

import UIKit

class LoginUpdateViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkTextField: UITextField!
    @IBOutlet weak var clicked: UIButton!
    
    let validator = Validator()
    var user = User(email: "", password: "", check: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clicked(_ sender: UIButton) {
        
        user = User(email: idTextField.text!, password: passwordTextField.text!, check: checkTextField.text!)
        
        if validator.isValidEmail(email: user.email) && validator.isValidPassword(password: user.password) && validator.isEqualPassword(password: user.password, check: user.check) {
            print("성공")
        } else {
            print("실패")
        }
    }
    

}
