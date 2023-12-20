//
//  ViewController.swift
//  SeSAC3Concurrency
//
//  Created by 김규철 on 2023/12/19.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var test2ImageView: UIImageView!
    @IBOutlet weak var test1ImageView: UIImageView!
    @IBOutlet weak var testImageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Network.shared.fetchThumbnail { [weak self] result in
        //            switch result {
        //            case .success(let value):
        //                DispatchQueue.main.async {
        //                    self?.testImageview.image = value
        //                }
        //            case .failure(let error):
        //                self?.testImageview.backgroundColor = .gray
        //                print(error)
        //            }
        //        }
        
        //        Task {
        //            // async를 사용했기 때문에 비동기 함수다 -> 근데 왜 동기 함수 내에서 사용하려고 하냐?
        //            // 그래서 Task 안에 넣어준다.
        //            // viewDidLoad는 동기, fetchThumbnailAsyncAwait는 비동기이기 때문에 이 사이의 연결고리가 Task다
        //            // Task는 어떻게보면 DispatchQueue.global().async
        //            // 시리얼큐로 동작하는걸 컨커런트큐로 동작하게 바꿔주는게 Task다.
        //            let image1 = try await Network.shared.fetchThumbnailAsyncAwait(value: "90D6sXfbXKhDpd4S1cHICdAe8VD")
        //            let image2 = try await Network.shared.fetchThumbnailAsyncAwait(value: "7EorldSdknaDtZd6Beohz8cNiTC")
        //            let image3 = try await Network.shared.fetchThumbnailAsyncAwait(value: "2ETx0U2Q5gUHtPJZiQ3hakTqyaR")
        //            testImageview.image = image1
        //            test1ImageView.image = image2
        //            test2ImageView.image = image3
        //        }
        
        //        DispatchQueue.global().async {
        //            Network.shared.fetchThumbnailAsyncAwait()
        //        }
        
//        Task {
//            let result = try await Network.shared.fetchThumbnailAsyncLet()
//
//            testImageview.image = result[0]
//            test1ImageView.image = result[1]
//            test2ImageView.image = result[2]
//        }
        
        Task {
            let result = try await Network.shared.fetchThumbnailTaskGroup()
            
            testImageview.image = result[0]
            test1ImageView.image = result[1]
            test2ImageView.image = result[2]
        }
    }
}

