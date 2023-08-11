//
//  TranslateAPIManager.swift
//  SeSAC3Week4
//
//  Created by 김규철 on 2023/08/11.
//

import Foundation

import Alamofire
import SwiftyJSON

final class TranslateAPIManager {
    
    static let shared = TranslateAPIManager()
    
    private init() {}
    
    func callRequest(text: String, completion: @escaping (String) -> (Void)) {
        let parameters: Parameters = [
            "source": "ko",
            "target": "es",
            "text": text
        ]
        
        AF.request(URLConstant.papago, method: .post, parameters: parameters, headers: DefaultHearder.hearder).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = json["message"]["result"]["translatedText"].stringValue
                completion(data)
            case .failure(let error):
                switch response.response?.statusCode {
                case 400:
                    completion("값이 없다.")
                case 500:
                    completion("서버 에러")
                default:
                    completion(error.localizedDescription)
                }
            }
            
        }
    }
}
