//
//  EndPointType.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/13.
//

import Foundation

import Alamofire

protocol EndPointType: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var headers: HeaderType { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
}

extension EndPointType {
    var baseURL: String {
        return URLConstants.base
    }
    
    var headers: HeaderType {
        return .withApiKey
    }
    
    func asURLRequest() throws -> URLRequest {
        /// - Returns: The `URL` initialized with `self`.
        /// - Throws:  An `AFError.invalidURL` instance.
        let url = try baseURL.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        urlRequest.headers = headers.toHTTPHeaders
        
        if let parameters = parameters {
              return try encoding.encode(urlRequest, with: parameters)
          }

          return urlRequest
    }
}
