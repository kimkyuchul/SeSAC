//
//  URLSessionEndPointType.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/09/02.
//

import Foundation

protocol URLSessionEndPointType {
    var baseURL: String { get }
    var headers: [String: String] { get }
    var path: String { get }
    var method: URLSessionHTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
}

extension URLSessionEndPointType {
    var baseURL: String {
        return URLConstants.base
    }
}
