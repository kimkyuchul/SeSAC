//
//  EndPointType.swift
//  SeSAC3Week4
//
//  Created by 김규철 on 2023/08/17.
//

import Foundation

import Alamofire

protocol EndPointType: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
}

extension EndPointType {
    var baseURL: String {
        return URL.baseURL
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders.default
        headers.add(name: "Authorization", value: "KakaoAK \(APIKey.kakaoKey)")
        return headers
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        urlRequest.headers = headers
        
        if let parameters = parameters {
              return try encoding.encode(urlRequest, with: parameters)
          }

          return urlRequest
    }
}
