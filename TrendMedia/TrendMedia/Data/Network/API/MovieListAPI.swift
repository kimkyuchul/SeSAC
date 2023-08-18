//
//  MovieListAPI.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/13.
//

import Foundation

import Alamofire

enum MovieAPI {
    case getTrandAPI
    case getCreditsAPI(movieId: Int)
    case getSimilarAPI(movieId: Int)
    case getRecommendationsAPI(movieId: Int)
}

extension MovieAPI: EndPointType {
    var path: String {
        switch self {
        case .getTrandAPI:
            return "/trending/movie/week"
        case .getCreditsAPI(let movieId):
            return "/movie/\(movieId)/credits"
        case .getSimilarAPI(let movieId):
            return "/movie/\(movieId)/similar"
        case .getRecommendationsAPI(let movieId):
            return "/movie/\(movieId)/recommendations"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getTrandAPI, .getCreditsAPI, .getSimilarAPI, .getRecommendationsAPI:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getTrandAPI, .getCreditsAPI, .getSimilarAPI, .getRecommendationsAPI:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getTrandAPI, .getCreditsAPI, .getSimilarAPI, .getRecommendationsAPI:
            return URLEncoding.default
        }
    }
}
