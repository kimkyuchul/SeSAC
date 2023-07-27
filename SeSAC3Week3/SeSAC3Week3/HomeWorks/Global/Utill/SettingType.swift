//
//  SettingType.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/27.
//

import Foundation

enum SettingType: String, CaseIterable {
    case allSetting = "전체 설정"
    case personalization = "개인 설정"
    case etc = "기타"
    
    var item: [String] {
        switch self {
        case .allSetting:
            return ["공지사항", "실험실", "버전 정보"]
        case .personalization:
            return ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .etc:
            return ["고객센터/도움말"]
        }
    }
    
    var numberOfRowsInSection: Int {
        switch self {
        case .allSetting, .personalization, .etc:
            return self.item.count
        }
    }
}
