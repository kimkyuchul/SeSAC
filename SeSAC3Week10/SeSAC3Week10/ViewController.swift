//
//  ViewController.swift
//  SeSAC3Week10
//
//  Created by 김규철 on 2023/09/19.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit

final class ViewController: UIViewController {
    
    private lazy var scrollView = {
        let view = UIScrollView()
        view.minimumZoomScale = 1
        view.maximumZoomScale = 4
        view.backgroundColor = .green
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let imageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        configureLayout()
        viewModel.request { [weak self] url in
            self?.imageView.kf.setImage(with: url)
        }
    }
    
    
    private func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture))
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
    }
    
    @objc private func doubleTapGesture() {
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(2, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    
    func configureHierachy() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
    
    func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalTo(view)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(scrollView)
        }
    }
    
    
    func request(query: String) {
        let key = "m27nyFvp2GSD19hxCU1HHKTfJ5__tD3PBSMq8MBJIOY"
        let url = "https://api.unsplash.com/search/photos?query=sky"
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(key)"]
        let query: Parameters = ["query": query]
        
        // 파라미터를 쿼리스트링으로 보내기 위한 encoding을 제공
        // Parameters는 post때 필요하다 body자리의 Parameters를 쿼리스트링으로 변경
        AF.request(url, method: .get, parameters: query, encoding: URLEncoding(destination: .queryString), headers: headers)
            .responseDecodable(of: Photo.self) { response in
                switch response.result {
                case .success(let photo):
                    dump(photo)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func randomRequest() {
        let key = "m27nyFvp2GSD19hxCU1HHKTfJ5__tD3PBSMq8MBJIOY"
        let url = "https://api.unsplash.com/photos/random"
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(key)"]
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let photo):
                    dump(photo)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func detailPhoto(id: String) {
        let key = "m27nyFvp2GSD19hxCU1HHKTfJ5__tD3PBSMq8MBJIOY"
        let url = "https://api.unsplash.com/photos/\(id)"
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(key)"]
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let photo):
                    dump(photo)
                case .failure(let error):
                    print(error)
                }
            }
        }
}

extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

struct Photo: Decodable, Hashable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable, Hashable {
    let id: String
    let created_at: String
    let urls: PhotoURL
    let width: CGFloat // 높이와 가로를 estimated하게 설정
    let height: CGFloat
}

struct PhotoURL: Decodable, Hashable {
    let full: String
    let thumb: String
}

