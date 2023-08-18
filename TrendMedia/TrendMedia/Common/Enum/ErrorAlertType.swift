//
//  ErrorAlertType.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/18.
//

import Foundation

enum ErrorAlertType: Error {
    case noneError
    
    var title: String {
        switch self {
        case .noneError: return "데이터가 없어요."
            
        }
    }
    
    var description: String {
        switch self {
        case .noneError: return "데이터가 없어요."

        }
    }
    
    var buttonTitle: String {
        switch self {
        case .noneError:
            return "확인"
        }
    }
}
