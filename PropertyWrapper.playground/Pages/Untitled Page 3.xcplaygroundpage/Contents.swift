//: [Previous](@previous)

import Foundation

// 열거형. 인스턴스 생성 x -> 인스턴스 메서드, 프로퍼티 불가
enum UserDefaultsManager {
    
    enum Key: String {
        case email
        case nickname
        case phone
    }
    
    static var email: String {
        get {
            UserDefaults.standard.string(forKey: UserDefaultsManager.Key.email.rawValue) ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsManager.Key.email.rawValue)
        }
    }
    
    static var nickname: String {
        get {
            UserDefaults.standard.string(forKey: UserDefaultsManager.Key.nickname.rawValue) ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsManager.Key.nickname.rawValue)
        }
    }
    
    static var phone: String {
        get {
            UserDefaults.standard.string(forKey: UserDefaultsManager.Key.phone.rawValue) ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsManager.Key.phone.rawValue)
        }
    }
}

UserDefaultsManager.email
UserDefaultsManager.nickname
UserDefaultsManager.phone

UserDefaultsManager.email = "4@r.com"

print("이메일 \(UserDefaultsManager.email)")
