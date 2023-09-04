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
    
    func callRequest(query: String, completionHandler: @escaping (JackPhoto?) -> Void) {
        guard let url = URL(string: URLConstants.base + "/search/photos?query=\(query)&client_id=\(APIKey.unsplash)") else { return }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        
        
        // global 스레드
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // 통신 시 DispatchQueue.main.async에 담아서 -> 사용부에서 main에 담지 않도록. 할 수 있다.
            // 만약 해당 통신이 여러번 쓰이게 된다면 사용부에서 쓸 때마다 main에 담아주는 일을 10번 해야 한다.
            DispatchQueue.main.async {
                if let error {
                    completionHandler(nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                    print(error) // Alert 또는 Do try catch 문
                    completionHandler(nil)
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil)
                    return
                    
                }
                
                do {
                    let result = try JSONDecoder().decode(JackPhoto.self, from: data)
                    completionHandler(result)
                } catch {
                    print(error) // 디코딩 오류 키
                }
                
                // try? -> 실패 시 오류를 방출하지 않고 nil 값을 넘기고 끝나기 때문에 디버깅이 어렵다.
                // let result = try? JSONDecoder().decode(t, from: data)
            }
            
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
