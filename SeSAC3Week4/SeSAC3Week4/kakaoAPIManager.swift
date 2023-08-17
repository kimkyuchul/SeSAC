//
//  kakaoAPIManager.swift
//  SeSAC3Week4
//
//  Created by 김규철 on 2023/08/11.
//

import Foundation

import Alamofire
import SwiftyJSON

class kakaoAPIManager {
    
    static let shared = kakaoAPIManager()
    
    private init() { }
    
    private let header: HTTPHeaders = ["Authorization":"KakaoAK \(APIKey.kakaoKey)"]
    
    func callRequest(type: Endpoint, query: String, completion: @escaping (JSON) -> ()) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = type.requestURL + text
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                print(response.request?.allHTTPHeaderFields)
                
                completion(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
