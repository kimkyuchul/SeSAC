//
//  SeSACAPI.swift
//  SeSAC3Week10
//
//  Created by 김규철 on 2023/09/19.
//

import Foundation
import Alamofire

//enum Router: URLRequestConvertible {
//    func asURLRequest() throws -> URLRequest {
//
//    }
//}

enum SeSACAPI {
    
    static let key = ""
    
    case search(query: String)
    case random
    case photo(id: String)
    
    private var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var endpoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL + "search/photos")!
        case .random:
            return URL(string: baseURL + "search/random")!
        case .photo(let id):
            return URL(string: baseURL + "photos/\(id)")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(SeSACAPI.key)"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var query: [String: String] {
        switch self {
        case .search(let query):
            return ["query": query]
        case .random, .photo:
            return ["": ""]
        }
    }
}

