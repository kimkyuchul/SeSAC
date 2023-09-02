//
//  URLSessionMovieAPI.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/09/02.
//

import Foundation

enum URLSessionMovieAPI {
    case getCreditsAPI(movieId: Int)
}

extension URLSessionMovieAPI: URLSessionEndPointType {
    
    var path: String {
        switch self {
        case .getCreditsAPI(let movieId):
            return "/movie/\(movieId)/credits"
        }
    }
    
    var method: URLSessionHTTPMethod {
        switch self {
        case .getCreditsAPI:
            return .get
        }
    }
    
    var headers: [String : String] {
        return ["accept": "application/json",
                "Authorization": "\(APIKey.base)"]
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getCreditsAPI:
            return nil
        }
    }
}
