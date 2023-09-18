//
//  LoginViewModel.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/12.
//

import Foundation

protocol LoginInput: AnyObject {
    var email: Observable<String?> { get }
    var pwd: Observable<String?> { get }
    var code: Observable<String?> { get }
}

protocol LoginOutput: AnyObject {
    var validEmail: Observable<Bool> { get }
    var validPwd: Observable<Bool> { get }
    var validCode: Observable<Bool> { get }
    var isLogin: Observable<Bool> { get }
}


class LoginViewModel: LoginInput, LoginOutput {
    
    var email: Observable<String?> = Observable("")
    var pwd: Observable<String?> = Observable("")
    var code: Observable<String?> = Observable("")
    
    
    let validEmail = Observable(true)
    let validPwd = Observable(true)
    let validCode = Observable(true)
    var isLogin = Observable(true)
    
    
    func checkPwdValidation() {
        
        guard let text = pwd.value else { return }
        
        if text.count >= 6 && text.count <= 10 {
            validEmail.value = false
        }
        validEmail.value = true
    }
    
    func checkEmail() {
        
        guard let text = email.value else { return }
        
        validEmail.value = text.contains("@")
    }
    
    func checkCode() {
        
        guard let text = code.value else { return }
        
        validCode.value = text.count >= 6
        
        for i in text {
            if !i.isNumber {
                validCode.value = false
            }
        }
    }
    
    func checkisLogin() {
        isLogin.value = validEmail.value && validPwd.value && validCode.value
    }
    
    func signIn(completion: @escaping () -> Void) {
        UserDefaults.standard.set(email.value, forKey: "id")
        completion()
    }
}
