//: [Previous](@previous)

import Foundation

enum Key {
    case email, nickname, phone
    
     fileprivate var name: String {
        switch self {
        case .email:
            return "email"
        case .nickname:
            return "nickname"
        case .phone:
            return "phone"
        }
    }
}

UserDefaults.standard.set("kyu@.ad.com", forKey: Key.email.name)
UserDefaults.standard.set("고래밥", forKey: Key.nickname.name)
UserDefaults.standard.set("2131", forKey: Key.phone.name)

UserDefaults.standard.string(forKey: Key.email.name)
UserDefaults.standard.string(forKey: Key.nickname.name)
UserDefaults.standard.string(forKey: Key.phone.name)

UserDefaults.standard.set("kyu@.a11d.com", forKey: Key.email.name)
UserDefaults.standard.set("고래ㄴㄴ밥", forKey: Key.nickname.name)
UserDefaults.standard.set("213111", forKey: Key.phone.name)

let value = UserDefaults.standard.string(forKey: Key.email.name)
print("이메일은 \(String(describing: value))")

