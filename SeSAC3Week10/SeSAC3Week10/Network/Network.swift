//
//  Network.swift
//  SeSAC3Week10
//
//  Created by 김규철 on 2023/09/19.
//

import Foundation
import Alamofire

final class Network {
    
    static let shared = Network()
    
    private init() { }
    
    func request<T: Decodable>(type: T.Type, api: Router, completion: @escaping (Result<T, SeSACError>) -> Void) {
        
        AF.request(api)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let AFerror):
                    print(AFerror)
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    completion(.failure(error))
                }
            }
    }
}

