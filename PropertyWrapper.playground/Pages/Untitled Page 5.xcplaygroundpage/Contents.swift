//: [Previous](@previous)

import Foundation

@propertyWrapper
struct JavierDefaults<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
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
    
    @JavierDefaults(key: Key.email.rawValue, defaultValue: "")
    static var email
    
    @JavierDefaults(key: Key.nickname.rawValue, defaultValue: "")
    static var nickname
    
    @JavierDefaults(key: Key.phone.rawValue, defaultValue: 0)
    static var phone
}

UserDefaultsManager.email

UserDefaultsManager.email = "1414@a.com"

UserDefaultsManager.phone = 14141

UserDefaultsManager.phone





