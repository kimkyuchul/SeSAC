//
//  UserDefault.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/27.
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

class ShoppingManager {
    
    @UserDefault(key: "shoppingList", defaultValue: [])
    static var shoppingList: [String]
}
