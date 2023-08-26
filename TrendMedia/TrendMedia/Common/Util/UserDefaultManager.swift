//
//  UserDefaultManager.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/26.
//

import Foundation

class UserDefaultManager {
    
    @UserDefault(key: "isFirstLogin", defaultValue: false)
    static var isFirstLogin: Bool
}
