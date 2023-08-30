//
//  PhotoAPI.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/31.
//

import Foundation

enum PhotoAPI {
    case getSearchPhoto(query: String)
}

extension PhotoAPI: EndPointType {
    
    var path: String {
        switch self {
        case .getSearchPhoto:
            return "/search/photos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSearchPhoto:
            return .get
        }
    }
    
    var headers: [String : String] {
        return ["accept": "application/json",
                "Authorization": "Client-ID \(APIKey.unsplash)"]
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .getSearchPhoto(query: query):
            return [URLQueryItem(name: "query", value: query)]
        }
    }
}
