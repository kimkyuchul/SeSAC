//
//  URLSessionViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/30.
//

import UIKit

final class URLSessionViewController: UIViewController {
    
    
    var session: URLSession!
    
    var total: Double = 0
    
    // 값이 중간에 안 올 수도 있으니 옵셔널로 선언한다.
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(result * 100)"
            print(result, total) // total이 제대로 들어오고 있는지 확인
        }
    }
    
    
    let progressLabel = {
        let v = UILabel()
        v.backgroundColor = .black
        v.textColor = .white
        return v
    }()
    let progressView = {
        let v = UIImageView()
        v.backgroundColor = .lightGray
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // nil이 아닌 상태로 초기화
        // buffer?.append(data)가 실행되기 위함
        buffer = Data()
        
        [progressLabel, progressView].forEach { view in
            self.view.addSubview(view)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        progressView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        
        view.backgroundColor = .white
        
        
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        
        
        // Delegate 메서드는 delegateQueue: .main에서 실행됨 (통신은 백에서 다른 didCompleteWithError등은 메인에서 동작한다.)
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        
        // dataTask에 클로저가 없게 사용하는 이유는 -> URLSessionDataDelegate로 값을 받아올거임
        session.dataTask(with: url!).resume()
    }
    
    // 카카오톡 사진 다운로드: 다운로드 중에 다른 채팅방으로 넘어간다면? 취소 버튼?
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 취소 액션(화면이 사라질 때 등)
        session.invalidateAndCancel() // 진행하고 있는게 있다면 취소해라 리소스를 바로 정리
        
        
        //기다렸다가 리소스 끝나면 정리
        session.finishTasksAndInvalidate()
    }
}

// dataTask로 요청을 하고 있기 때문에 URLSessionDataDelegate
extension URLSessionViewController: URLSessionDataDelegate {
    
    // 서버에서 최초로 응답 받은 경우에 호출(상태코드 처리)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print("Response", response)
        
        if let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) {
            total = Double(response.value(forHTTPHeaderField: "Content-Length")!)!
            
            return .allow
        } else {
            return .cancel
        }
    }
    
    // 서버에서 데이터 받을 때마다 반복적으로 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("data", data) // 데이터가 계속 append가 되고 있는 것은 확인
        // 옵셔널 체이닝에 의해서 데이터가 nil로 오고 있다.
        //buffer가 nil이면 apeend 구문 실행 x
        buffer?.append(data)
    }
    
    // 서버에서 응답이 완료가 된 이후에 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("끝끝끝끝끝끝끝끝")
        
        if let error {
            print(error)
        } else {
            
            guard let buffer = buffer else {
                print(error)
                return
            }
            
            progressView.image = UIImage(data: buffer)
            
        }
    }
}
