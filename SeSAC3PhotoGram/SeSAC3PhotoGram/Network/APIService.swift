//
//  APIService.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/30.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    private init() { }
    
    func callRequest() {
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(data)
            print(response)
            print(error)
        }.resume() // 네트워크 통신이 시작되어야 하는 init
        
    }
}
