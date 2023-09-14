//
//  LottoService.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/13.
//

import Foundation

final class LottoService {
    
    static let shared = LottoService()
    
    private init() { }
    
    func lottoService(number: Int, completion: @escaping (Result<Lotto?, Error>) -> Void ) {
    
        guard let url = URL(string: "https://dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)") else {
            return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print(error)
                completion(.failure((error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Lotto.self, from: data!)
                completion(.success((result)))
                
            } catch {
                print(error)
            }
        }.resume()
        
    }

}
