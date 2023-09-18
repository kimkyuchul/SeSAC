//
//  RandomService.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/18.
//

import Foundation
 
final class RandomService {
    
    static let shared = RandomService()
    
    private init() { }
    
    func searchPhoto(completion: @escaping ([ImageInfo]) -> Void ) {
    
        guard let url = URL(string: "https://api.unsplash.com/photos/random?count=30&client_id=\(APIKey.unsplash)") else { return }

        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode([ImageInfo].self, from: data!)
                completion(result)
                
            } catch {
                print(error)
            }
        }.resume()
        
    }

}

