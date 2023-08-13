//
//  HeaderType.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/13.
//

import Foundation

import Alamofire

enum HeaderType {
    case `default`
    case withApiKey
}

extension HeaderType {
    // HTTPHeaders: 헤더 필드 여러개
    // HTTPHeader: 헤더 필드 한개
    
    var toHTTPHeaders: HTTPHeaders {
        switch self {
        case .default:
            var headers = HTTPHeaders.default
            headers.add(name: "accept", value: "application/json")
            return headers
        case .withApiKey:
            var headers = HTTPHeaders.default
            headers.add(name: "accept", value: "application/json")
            headers.add(name: "Authorization", value: APIKey.base)
            return headers
        }
    }
}
