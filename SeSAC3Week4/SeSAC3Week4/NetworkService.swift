//
//  NetworkService.swift
//  SeSAC3Week4
//
//  Created by 김규철 on 2023/08/10.
//

import Foundation

import Alamofire
import SwiftyJSON

protocol PaPagoNetwork: AnyObject {
    func postDetectLanguage(query: String, completion: @escaping (Result<String, NetworkError>) -> Void)
    func postTranslateLanguage(langCode: String, text: String, completion: @escaping (Result<String, NetworkError>) -> Void)
}


// 싱글턴으로 정의하게 되면 -> postDetectLanguage 안에서 NetworkService를 한번 더 불러야 하는 상황이 발생
final class NetworkService: PaPagoNetwork  {

    func postDetectLanguage(query: String, completion: @escaping (Result<String, NetworkError>) -> Void)  {
        let parameters: Parameters = [
            "query": query
        ]
        
        AF.request(URLConstant.detectLangs, method: .post, parameters: parameters, headers: DefaultHearder.hearder).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = json["langCode"].stringValue
                completion(.success(data))
            case .failure(let error):
                switch response.response?.statusCode {
                case 400:
                    completion(.failure(.Emptytext))
                case 500:
                    completion(.failure(.InternalServerErrors))
                default:
                    completion(.failure(.unknownError(error)))
                }
            }
            
        }
    }
    
    func postTranslateLanguage(langCode: String, text: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let parameters: Parameters = [
            "source": langCode,
            "target": "es",
            "text": text
        ]
        
        AF.request(URLConstant.papago, method: .post, parameters: parameters, headers: DefaultHearder.hearder).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = json["message"]["result"]["translatedText"].stringValue
                completion(.success(data))
            case .failure(let error):
                switch response.response?.statusCode {
                case 400:
                    completion(.failure(.Emptytext))
                case 500:
                    completion(.failure(.InternalServerErrors))
                default:
                    completion(.failure(.unknownError(error)))
                }
            }
            
        }
    }
}
