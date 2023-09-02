//
//  BaseURLSessionService.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/09/02.
//

import Foundation

final class BaseURLSessionService {
    
    static let shared = BaseURLSessionService()
    
    private init() { }
    
    func baseRequest<T: Decodable>(
        type: T.Type, endPoint: URLSessionEndPointType,
        completed: @escaping (Result<T, Error>) -> Void
    ) {
        
        guard let urlRequest = asURLRequest(endPoint: endPoint) else { return completed(.failure(URLSessionError.unknownError))  }
        
        URLSession.shared
            .dataTask(
                with: urlRequest,
                completionHandler: { data, response, error in
                    
                    DispatchQueue.main.async {
                        guard error == nil else { return completed(.failure(URLSessionError.urlSessionError(error!)))}
                        
                        if let response = response as? HTTPURLResponse,
                           !(200...299).contains(response.statusCode) {
                            completed(.failure(URLSessionError.configureHTTPError(code: response.statusCode)))
                        }
                        
                        guard let data = data else {
                            completed(.failure(URLSessionError.emptyDataError))
                            return
                        }
                        
                        do {
                            let result = try JSONDecoder().decode(type, from: data)
                            completed(.success(result))
                        } catch {
                            completed(.failure(error))
                        }
                    }
                }
            )
            .resume()
    }
}

private extension BaseURLSessionService {
    func asURLRequest(endPoint: URLSessionEndPointType) -> URLRequest? {
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



