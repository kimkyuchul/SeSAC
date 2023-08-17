//
//  kakaoVideoAPI.swift
//  SeSAC3Week4
//
//  Created by 김규철 on 2023/08/17.
//

import Foundation

import Alamofire

enum kakaoVideoAPI {
    case getVideo(query: String, page: Int)
}

extension kakaoVideoAPI: EndPointType {
    var path: String {
        switch self {
        case .getVideo:
            return "/vclip"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getVideo:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getVideo(query: let query, page: let page):
            return ["query": query, "page": page]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getVideo:
            return URLEncoding.default
        }
    }
}
