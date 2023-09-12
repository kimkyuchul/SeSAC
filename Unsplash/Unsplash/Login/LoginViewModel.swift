//
//  LoginViewModel.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/12.
//

import Foundation

class LoginViewModel {
    
    var id = Observable("")
    var pwd = Observable("1234")
    var isLogin = Observable(false)
    
    
    func checkValidation() {
        if id.value.count >= 6 && pwd.value.count >= 4 {
            isLogin.value = true
        } else {
            isLogin.value = false
        }
    }
    
    func signIn(completion: @escaping () -> Void) {
        UserDefaults.standard.set(id.value, forKey: "id")
        completion()
    }
}
