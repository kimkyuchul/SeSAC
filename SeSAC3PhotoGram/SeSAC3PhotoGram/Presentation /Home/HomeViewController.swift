//
//  HomeViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/31.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    var list: JackPhoto = JackPhoto(total: 0, total_pages: 0, results: [])

    private let homeView = HomeView()
    
    override func loadView() {
        homeView.delegate = self
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        print(self, #function)
        APIService.shared.callRequest(query: "mac") { photo in
            guard let photo = photo else  {
                print("")
                return
            }
            
            print("API END")
            self.list = photo
            print(photo)
            
            self.homeView.collectionView.reloadData()
            
        }
    }
    
    deinit {
        print(self, #function)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
//        cell.imageView.backgroundColor = .systemPink
        
        let thumb = list.results[indexPath.item].urls.thumb
        
        let url = URL(string: thumb) // 링크를 기반으로 이미지를 보여준다라는 것은 -> 네트워크 통신이다.
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url!) // 동기 코드
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
//        delegate?.dldSelectItemAt(indexPath: indexPath)
    }
}

extension HomeViewController: HomeViewProtocol {
    func dldSelectItemAt(indexPath: IndexPath) {
        print(indexPath)
        navigationController?.popViewController(animated: true)
    }
}
