//
//  MovieListAPI.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/13.
//

import Foundation

import Alamofire

enum MovieListAPI {
    case getTrandAPI
    case getCreditsAPI(movieId: Int)
}

extension MovieListAPI: EndPointType {
    var path: String {
        switch self {
        case .getTrandAPI:
            return "/trending/movie/week"
        case .getCreditsAPI(let movieId):
            return "/movie/\(movieId)/credits"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getTrandAPI, .getCreditsAPI:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getTrandAPI, .getCreditsAPI:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getTrandAPI, .getCreditsAPI:
            return URLEncoding.default
        }
    }
}
