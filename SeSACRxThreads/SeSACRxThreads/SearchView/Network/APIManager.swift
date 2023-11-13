//
//  APIManager.swift
//  SeSACRxThreads
//
//  Created by 김규철 on 2023/11/06.
//

import Foundation

import RxSwift

enum APIError: Error {
    case invaildURL
    case unknown
}

final class APIManager {
    
    static func fetchData() -> Observable<SearchAppModel> {
        
        Observable<SearchAppModel>.create { emitter in
            let url = "https://itunes.apple.com/search?term=todo&country=KR&media=software&lang=ko_KR&limit=10"
            
            guard let url = URL(string: url) else {
                emitter.onError(APIError.invaildURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                print("URLSession Succeed") // 3번 서브스크라이브 하면 3번 호출
                
                if let _ = error {
                    emitter.onError(APIError.unknown)
                    return // dataTask의 반환 타입은 Void
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    emitter.onError(APIError.unknown)
                    return
                }
                
                
                if let data = data, let appData = try? JSONDecoder().decode(SearchAppModel.self, from: data) {
                    emitter.onNext(appData)
                }
            }.resume()
            
            return Disposables.create()
        }
    }
}
