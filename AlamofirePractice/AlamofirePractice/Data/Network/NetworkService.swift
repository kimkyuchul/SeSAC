//
//  NetworkService.swift
//  AlamofirePractice
//
//  Created by 김규철 on 2023/08/08.
//

import Foundation

import Alamofire
import SwiftyJSON

final class NetworkService {
    
    static let shared = NetworkService()
    
    func getRamdomBeerData(completion: @escaping (RandomBeer) -> ()) {
        AF.request(APIConstant.randomURL, method: .get).validate(statusCode: 200...399).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                guard let name = json[0]["name"].string else { return }
                guard let imageURL = json[0]["image_url"].string else { return }
                guard let description = json[0]["description"].string else { return }
                
                completion(RandomBeer(name: name, imageURL: imageURL, description: description))
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getBeerListData(completion: @escaping ([Beer]) -> ()) {
        AF.request(APIConstant.baseURL, method: .get).validate(statusCode: 200...399).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var beerArray: [Beer] = []
                
                for item in json.arrayValue {
                    let title = item["name"].stringValue
                    let imageURL = item["image_url"].stringValue
                    let description = item["description"].stringValue
                    let firstBrewed = item["first_brewed"].stringValue
                    
                    let beer = Beer(name: title, imageURL: imageURL, description: description, first_brewed: firstBrewed)
                    
                    beerArray.append(beer)
                }
                completion(beerArray)
            case .failure(let error):
                print(error)
            }
        }
    }
}
