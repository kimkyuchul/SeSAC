//
//  EndPointType.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/31.
//

import Foundation

protocol EndPointType {
    var baseURL: String { get }
    var headers: [String: String] { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
}

extension EndPointType {
    var baseURL: String {
        return URLConstants.base
    }
}
