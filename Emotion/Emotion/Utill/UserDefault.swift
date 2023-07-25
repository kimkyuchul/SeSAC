//
//  UserDefault.swift
//  Emotion
//
//  Created by 김규철 on 2023/07/25.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: self.key) as? T ?? self.defaultValue
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: self.key)
        }
    }
}
