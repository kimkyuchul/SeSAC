//
//  LottoManager.swift
//  SeSAC3Week5
//
//  Created by 김규철 on 2023/08/17.
//

import Foundation

import Alamofire

class LottoManager {
    
    static let shared = LottoManager()
    
    func callLotto( completionHandler: @escaping (Int, Int) -> Void) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Lotto.self) { response in
                guard let value = response.value else { return }
                print("responseDecodable:", value)
                
                // 두가지 요소를 VC에서 쓰고 싶다. => 이스케이핑
                print(value.bnusNo, value.drwtNo3)
                completionHandler(value.bnusNo, value.drwtNo3)
            }
    }
}
