//
//  ProfileType.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/29.
//

import Foundation

enum ProfileType: CaseIterable {
    case name
    case userName
    case gender
    case introduce
    
    var title: String {
        switch self {
        case .name:
            return "이름"
        case .userName:
            return "사용자 이름"
        case .gender:
            return "성별"
        case .introduce:
            return "소개"
        }
    }
}
