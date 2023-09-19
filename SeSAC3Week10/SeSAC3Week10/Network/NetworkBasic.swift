//
//  NetworkBasic.swift
//  SeSAC3Week10
//
//  Created by 김규철 on 2023/09/19.
//

import Foundation
import Alamofire

enum SeSACError: Int, Error, LocalizedError {
    case unauthorized = 401
    case permissionDenied = 403
    case invalidServer = 500
    case missingParameter = 400
    
    var errorDescription: String {
        switch self {
        case .unauthorized:
            return "unauthorized"
        case .permissionDenied:
            return "permissionDenied"
        case .invalidServer:
            return "invalidServer"
        case .missingParameter:
            return "missingParameter"
        }
    }
}

final class NetworkBasic {
    
    static let shared = NetworkBasic()
    
    private init() { }
    
    func request(api: SeSACAPI, query: String, completion: @escaping (Result<Photo, SeSACError>) -> Void) {
        let url = "https://api.unsplash.com/search/photos?query=sky"
        
        // 파라미터를 쿼리스트링으로 보내기 위한 encoding을 제공
        // Parameters는 post때 필요하다 body자리의 Parameters를 쿼리스트링으로 변경
        AF.request(api.endpoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString), headers: api.header)
            .responseDecodable(of: Photo.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    completion(.failure(error))
                }
            }
    }
    
    func detailPhoto(api: SeSACAPI, id: String, completion: @escaping (Result<PhotoResult, SeSACError>) -> Void) {
        let key = "m27nyFvp2GSD19hxCU1HHKTfJ5__tD3PBSMq8MBJIOY"
        let url = "https://api.unsplash.com/photos/\(id)"
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(key)"]
        
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let photo):
                    dump(photo)
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    completion(.failure(error))
                }
            }
    }
}
