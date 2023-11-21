//
//  UpbitAPI.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/21.
//

import Foundation

//struct MarketArray: Codable {
//    let market: [Market]
//}

struct Market: Codable, Hashable {
    let market: String
    let korean: String
    let english: String
    
    enum CodingKeys: String, CodingKey {
        case market
        case korean = "korean_name"
        case english = "english_name"
    }
}

struct UpbitAPI {
    private init() { }
    
    static func fetchAllMarket(completion: @escaping ([Market]) -> Void) {
        
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("no data")
                return
            }
            
            do {
                let result = try JSONDecoder().decode([Market].self, from: data)
                
                DispatchQueue.main.async {
                    completion(result)
                }
                
            } catch {
                print(error)
            }
        }
        .resume()
    }
}
