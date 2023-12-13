//
//  NetworkManager.swift
//  SeSACTest
//
//  Created by 김규철 on 2023/12/13.
//

import Foundation

import Alamofire

protocol NetworkProvider {
    func fetchLotto(completionHandler: @escaping (Lotto) -> Void)
}

class NetworkManager: NetworkProvider {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=861"
    
    func fetchLotto(completionHandler: @escaping (Lotto) -> Void) {
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let success):
                print(success)
                completionHandler(success)
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct Lotto: Codable {
    let drwNoDate: String
    let bnusNo: Int
    let drwtNo1: Int
}
