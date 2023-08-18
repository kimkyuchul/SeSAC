//
//  NetworkError.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/18.
//

import Foundation

enum NetworkError: Error {
    case notBeFoundData
    case noneError(error: Error)
    
    var errorMessage: String {
        switch self {
        case .notBeFoundData:
            return "404 // he resource you requested could not be found."
        case .noneError(error: let error):
            return error.localizedDescription
        }
    }
}
