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
        }.resume() // 네트워크 통신이 시작되어야 하는 init
        
    }
    
    func requstCall<T: Decodable>(
        type: T.Type, endPoint: EndPointType,
        completed: @escaping (Result<T, Error>) -> Void
    ) {
        
        guard let urlRequest = asURLRequest(endPoint: endPoint) else { return completed(.failure(NetworkError.unknownError))  }
        
        URLSession.shared
            .dataTask(
                with: urlRequest,
                completionHandler: { data, response, error in
                    
                    guard error == nil else { return completed(.failure(NetworkError.urlSessionError(error!)))}
                    
                    if let response = response as? HTTPURLResponse,
                       !(200...299).contains(response.statusCode) {
                        completed(.failure(NetworkError.configureHTTPError(code: response.statusCode)))
                    }
                    
                    guard let data = data else {
                        completed(.failure(NetworkError.emptyDataError))
                        return
                    }
                    
                    do {
                        let result = try JSONDecoder().decode(type, from: data)
                        completed(.success(result))
                    } catch {
                        completed(.failure(error))
                    }
                }
            )
            .resume()
    }
    
    
}

private extension APIService {
    func asURLRequest(endPoint: EndPointType) -> URLRequest? {
        guard var components = URLComponents(string: endPoint.baseURL) else {
            return nil
        }

        components.path += endPoint.path
        components.queryItems = endPoint.queryItems

        guard let url = components.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.method.rawValue

        for (key, value) in endPoint.headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        return urlRequest
    }
}
