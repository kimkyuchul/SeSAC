//
//  SearchViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/28.
//

import UIKit

import Kingfisher

class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    
    weak var delegate: PassImageProtocol?
    
    let imageList = ["pencil", "star", "person", "star.fill", "xmark"]
    private var photoURLData: [String] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // addObserver는 post보다 미리 등록되어있어야 하기 때문에, 정방향으로 데이터 전송 시 실행되지 않음
        // addVC (post) -> search(addObserver) 형태이기 때문에 post 할 때 addObserver가 미리 등록되어 있지 않았다.
        // addObserver보다 post가 먼저 신호를 보내면 받을 수 없음
        NotificationCenter.default.addObserver(self, selector: #selector(recommandKetwordNotificationObserver), name: NSNotification.Name("RecommandKeyword"), object: nil)
        
        mainView.searchBar.becomeFirstResponder()
        mainView.searchBar.delegate = self

    }
    
    deinit {
        print(self)
    }
    
    @objc func recommandKetwordNotificationObserver(notification: NSNotification) {
        print(recommandKetwordNotificationObserver)
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    override func configureView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }

}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoURLData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.kf.setImage(
                    with: URL(string: photoURLData[indexPath.item])
                )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(photoURLData[indexPath.row])
        
//        NotificationCenter.default.post(name: NSNotification.Name("SelectImage"), object: nil, userInfo: ["name": imageList[indexPath.row], "sample": "고래밥"])
        
        self.delegate?.receiveImage(ImageString: photoURLData[indexPath.row])
        
        dismiss(animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        guard let query = searchBar.text else { return }
        
        APIService.shared.requstCall(type: PhotoURLPage.self, endPoint: PhotoAPI.getSearchPhoto(query: query)) { [weak self] result in
            switch result {
            case .success(let data):
                guard let urls = data.results?.compactMap({ $0.urls?.regular }) else { return }
                self?.photoURLData = urls
                
                DispatchQueue.main.async {
                    self?.mainView.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        mainView.searchBar.text = ""
        mainView.searchBar.resignFirstResponder()
    }
}
