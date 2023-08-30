//
//  URLSessionViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/30.
//

import UIKit

final class URLSessionViewController: UIViewController {
    
    
    var session: URLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        
        // dataTask에 클로저가 없게 사용하는 이유는 -> URLSessionDataDelegate로 값을 받아올거임
        session.dataTask(with: url!).resume()
    }
}

// dataTask로 요청을 하고 있기 때문에 URLSessionDataDelegate
extension URLSessionViewController: URLSessionDataDelegate {
    
    // 서버에서 최초로 응답 받은 경우에 호출(상태코드 처리)
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
//        print("Response", response)
//    }
    
    // 서버에서 데이터 받을 때마다 반복적으로 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("data", data)
    }
    
    // 서버에서 응답이 완료가 된 이후에 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("끝끝끝끝끝끝끝끝")
    }
}
