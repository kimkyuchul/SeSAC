//
//  BaseService.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/13.
//

import Foundation

import Alamofire

final class BaseService {
    
    static let shared = BaseService()
    
    private init() {}
        
    func request<T: Codable>(target: EndPointType, _ type: T.Type, completion: @escaping (Result<T, NetworkError>) -> (Void)) {
        AF.request(target)
            .validate()
            .responseDecodable(of: type) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    switch response.response?.statusCode {
                    case 404:
                        completion(.failure(NetworkError.notBeFoundData))
                    default:
                        completion(.failure(NetworkError.noneError(error: error)))
                    }
                }
            }
    }
}
