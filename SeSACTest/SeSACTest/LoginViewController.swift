//
//  LoginViewController.swift
//  SeSACTest
//
//  Created by 김규철 on 2023/12/11.
//

import UIKit

import Combine

class LoginViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkTextField: UITextField!
    @IBOutlet weak var clicked: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func clicked(_ sender: UIButton) {
        
        if isValidEmail() && isValidPassword() && isEqualPassword() {
            print("성공")
        } else {
            print("실패")
        }
    }
    
    func isValidEmail() -> Bool {
        guard let check = idTextField.text else {
            return false
        }
        
        return check.contains("@") && check.count >= 6
    }
    
    func isValidPassword() -> Bool {
        guard let check = passwordTextField.text else {
            return false
        }
        
        return check.count >= 6 && check.count < 10
    }
    
    func isEqualPassword() -> Bool {
        guard let password = passwordTextField.text, let check = checkTextField.text else {
            return false
        }
        
        return password == check
    }
}
