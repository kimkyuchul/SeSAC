//
//  SearchViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/28.
//

import UIKit

class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    
    let imageList = ["pencil", "star", "person", "star.fill", "xmark"]
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // addObserver는 post보다 미리 등록되어있어야 하기 때문에, 정방향으로 데이터 전송 시 실행되지 않음
        // addVC (post) -> search(addObserver) 형태이기 때문에 post 할 때 addObserver가 미리 등록되어 있지 않았다.
        // addObserver보다 post가 먼저 신호를 보내면 받을 수 없음
        NotificationCenter.default.addObserver(self, selector: #selector(recommandKetwordNotificationObserver), name: NSNotification.Name("RecommandKeyword"), object: nil)

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
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.image = UIImage(systemName: imageList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(imageList[indexPath.row])
        
        NotificationCenter.default.post(name: NSNotification.Name("SelectImage"), object: nil, userInfo: ["name": imageList[indexPath.row], "sample": "고래밥"])
        
        dismiss(animated: true)
    }
    
}
