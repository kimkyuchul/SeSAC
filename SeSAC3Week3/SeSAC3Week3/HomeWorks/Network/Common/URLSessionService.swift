//
//  URLSessionService.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/28.
//

import Foundation

final class URLSessionService {
    
    static let shard = URLSessionService()
    
    private let decoder = JSONDecoder()
    
    func getMovieList(page: Int, completion: @escaping (MovieListResponse) -> Void) {
        
        let apiKey = Bundle.main.MOVIE_API_KEY
        
        guard var urlComponents = URLComponents(string: BaseURLConstant.base) else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "s", value: BaseURLConstant.search),
            URLQueryItem(name: "type", value: BaseURLConstant.type),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        guard let url = urlComponents.url else {
            print("URL 오류")
            return
        }
        
        URLSession(configuration: .default).dataTask(with: url) {  data, response, error in
            
            guard let data = data, error == nil else { return }
            
            if let response = response as? HTTPURLResponse {
                guard let movieData = try? self.decoder.decode(MovieListResponse.self, from: data) else { return print("파싱 오류") }
                completion(movieData)
            }
            
        }.resume()
    }
}
