//
//  Network.swift
//  SeSAC3Concurrency
//
//  Created by 김규철 on 2023/12/19.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case unkown
    case invalidResponse
    case invalidImage
}

/*
GCD vs Swift Concurrency
 - completion handler
 - 비동기를 동기처럼
 
 - Thread Explosion
 - Context Switching
 -> 코어의 수와 쓰레드의 수를 같게
 -> 같은 쓰레드 내에서 Continuation 전환 형식으로 방식을 변경
 
 - async throws / try await : 비동기를 동기처럼
 - Task : 비동기 함수와 동기 함수를 연결
 - async let : (ex. DispatchGroup)
    - 통신 횟수가 명확한다면 사용하자.
 - taskGroup : 몇개의 네트워크 통신이 들어올지 모를 때
*/

final class Network {
    
    static let shared = Network()
    
    private init() { }
    
    func fetchThumbnail(completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let url = URL(string: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/2ETx0U2Q5gUHtPJZiQ3hakTqyaR.jpg")!
        
        // cachePolicy -> Cache 정책, timeoutInterval 설정
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data else {
                completion(.failure(.unkown))
                return
            }
            
            guard error == nil else {
                completion(.failure(.unkown))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.invalidImage))
                return
            }
            
            completion(.success(image))
                    
        }.resume()
    }
    
    // async -> 나 비동기로 작업할거임, 비동기로 작업할 함수다.
    // throws -> 에러도 던질거임
    func fetchThumbnailAsyncAwait(value: String) async throws -> UIImage {

        let url = URL(string: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/\(value).jpg")!
        // cachePolicy -> Cache 정책, timeoutInterval 설정
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5)
        
        // 비동기로 동작하고 있다. func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)? = nil) async throws -> (Data, URLResponse)
        // 비동기 함수를 동기적으로 처리할 수 있도록 -> try await
        // await: 비동기를 동기처럼 작업 할꺼니까, 응답 올떄까지 기다려라
        // 다음코드가 실행되지 않고 해당 코드의 응답이 오고나서 실행되도록 await
        // 비동기로 동작하는 코드 앞에는 try await
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        guard let image = UIImage(data: data) else {
            throw NetworkError.invalidImage
        }
        
        print(url.description)
        
        return image
    }
    
    func fetchThumbnailAsyncLet() async throws -> [UIImage] {
        // 비동기 동작
        // 응답이 오는 결과는 중요하지 않고 하나의 그룹으로 묶어서 처리하고 싶을 때 async let을 활용한다.
        async let result1 = Network.shared.fetchThumbnailAsyncAwait(value: "90D6sXfbXKhDpd4S1cHICdAe8VD")
        async let result2 = Network.shared.fetchThumbnailAsyncAwait(value: "7EorldSdknaDtZd6Beohz8cNiTC")
        async let result3 = Network.shared.fetchThumbnailAsyncAwait(value: "2ETx0U2Q5gUHtPJZiQ3hakTqyaR")
        
        // 비동기 작업이 모두 끝나고 실행되라 -> try await가 붙여지는 이유
        return try await [result1, result2, result3]
    }
    
    //  async let의 문제점을 보완 -> 응답이 오는 순서대로 
    func fetchThumbnailTaskGroup() async throws -> [UIImage] {
        let poster = ["90D6sXfbXKhDpd4S1cHICdAe8VD", "7EorldSdknaDtZd6Beohz8cNiTC", "2ETx0U2Q5gUHtPJZiQ3hakTqyaR"]
        
        return try await withThrowingTaskGroup(of: UIImage.self) { group in
            
            for item in poster {
                // 네트워크 과정을 추가
                group.addTask {
                    try await self.fetchThumbnailAsyncAwait(value: item)
                }
            }
            
            var resultImages: [UIImage] = []
            
            for try await item in group {
                resultImages.append(item)
            }
            
            return resultImages
        }
    }
}
