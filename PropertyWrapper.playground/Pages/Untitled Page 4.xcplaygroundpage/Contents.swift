//: [Previous](@previous)

import Foundation

struct JavierDefaults<T> {
    let key: String
    let defaultValue: T
    
    var myValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

enum UserDefaultsManager {
    
    enum Key: String {
        case email
        case nickname
        case phone
    }
    
    static var email = JavierDefaults(key: Key.email.rawValue, defaultValue: "이메일 없음")
    
    static var nickname = JavierDefaults(key: Key.nickname.rawValue, defaultValue: "닉 없음")
    
    static var phone = JavierDefaults(key: Key.phone.rawValue, defaultValue: 1314124)
}

UserDefaultsManager.email.myValue

UserDefaultsManager.email.myValue = "1414@a.com"

UserDefaultsManager.phone.myValue = 14141

UserDefaultsManager.phone.myValue




