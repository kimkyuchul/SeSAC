//
//  NetworkError.swift
//  SeSAC3Week4
//
//  Created by 김규철 on 2023/08/10.
//

import Foundation

enum NetworkError: Error {
    case Emptytext
    case InternalServerErrors
    case unknownError(Error)
    
    var errorString: String {
        switch self {
        case .Emptytext:
            return "text가 없습니다"
        case .InternalServerErrors:
            return "Internal server errors"
        case .unknownError(_):
            return "unknownError"
        }
    }
}
