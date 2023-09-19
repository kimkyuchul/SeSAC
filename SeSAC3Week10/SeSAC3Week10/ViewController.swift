//
//  ViewController.swift
//  SeSAC3Week10
//
//  Created by 김규철 on 2023/09/19.
//

import UIKit
import Alamofire

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        request(query: "ada")
        
        //        randomRequest()
        
//        detailPhoto(id:"u1RTD_7krSo")
        
//        NetworkBasic.shared.detailPhoto(id: "u1RTD_7krSo") { result in
//            switch result {
//            case .success(let data):
//                print(data)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        Network.shared.request(type: Photo.self, api: SeSACAPI.photo(id: "apple")) { result in
            switch result {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                dump(failure)
            }
        }
    }
    
    func request(query: String) {
        let key = "m27nyFvp2GSD19hxCU1HHKTfJ5__tD3PBSMq8MBJIOY"
        let url = "https://api.unsplash.com/search/photos?query=sky"
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(key)"]
        let query: Parameters = ["query": query]
        
        // 파라미터를 쿼리스트링으로 보내기 위한 encoding을 제공
        // Parameters는 post때 필요하다 body자리의 Parameters를 쿼리스트링으로 변경
        AF.request(url, method: .get, parameters: query, encoding: URLEncoding(destination: .queryString), headers: headers)
            .responseDecodable(of: Photo.self) { response in
                switch response.result {
                case .success(let photo):
                    dump(photo)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func randomRequest() {
        let key = "m27nyFvp2GSD19hxCU1HHKTfJ5__tD3PBSMq8MBJIOY"
        let url = "https://api.unsplash.com/photos/random"
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(key)"]
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let photo):
                    dump(photo)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func detailPhoto(id: String) {
        let key = "m27nyFvp2GSD19hxCU1HHKTfJ5__tD3PBSMq8MBJIOY"
        let url = "https://api.unsplash.com/photos/\(id)"
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(key)"]
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let photo):
                    dump(photo)
                case .failure(let error):
                    print(error)
                }
            }
    }
}

struct Photo: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable {
    let id: String
    let created_at: String
    let urls: PhotoURL
}

struct PhotoURL: Decodable {
    let full: String
    let thumb: String
}

