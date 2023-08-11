//
//  UserDefaultsHelper.swift
//  SeSAC3Week4
//
//  Created by 김규철 on 2023/08/11.
//

import Foundation

class UserDefaultsHelper {
    
    static let shard = UserDefaultsHelper()
    
    let userDefaults = UserDefaults.standard
    
    private init() {} // 인스턴스 만들지 못하도록 -> 초기화 되지 못하도록
    
    enum Key: String { // 컴파일 최적화
        case nickname, age
    }
    
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? ""
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
}


