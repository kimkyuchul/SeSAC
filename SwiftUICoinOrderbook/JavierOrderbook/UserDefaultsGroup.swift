//
//  UserDefaultsGroup.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/30.
//

import Foundation

extension UserDefaults {
    
    static var groupShared: UserDefaults {
        let appGroupID = "group.sesac.JavierWallet"
        // appGroupID 내에 UserDefault에 저장
        // App과 Widget 둘 다 접근 가능한 UserDefault
        return UserDefaults(suiteName: appGroupID)!
    }
}
