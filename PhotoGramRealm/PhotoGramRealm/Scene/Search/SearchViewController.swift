//
//  SearchViewController.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/04.
//

import UIKit
import SnapKit
import Kingfisher

class SearchViewController: BaseViewController {
     
    let searchBar = {
       let view = UISearchBar()
        view.placeholder = "검색어를 입력해주세요"
        return view
    }()
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.delegate = self
        view.dataSource = self
        return view
    }()

    var didSelectItemHandler: ((String) -> Void)?
    
    private var imageList: Photo = Photo(total: 0, total_pages: 0, results: [])
    private var appearance = UICollectionLayoutListConfiguration.Appearance.insetGrouped
    var cellRegisteration: UICollectionView.CellRegistration<UICollectionViewListCell, PhotoResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIService.shared.searchPhoto(query: "sky") { data in
            guard let data = data else { return }
            self.imageList = data
            print(data)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        cellRegisteration = UICollectionView.CellRegistration(handler: { cell, indexPath, photoResult in
            var content = cell.defaultContentConfiguration()
            content.text = photoResult.user.username
            content.secondaryText = photoResult.description
            DispatchQueue.global().async {
                let url = URL(string: photoResult.urls.thumb)!
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
            }
        })
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout{ [unowned self] section, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: self.appearance)
            config.headerMode = .firstItemInSection
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        }
    }
    
     
    override func configure() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
    }

 
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.results!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = imageList.results![indexPath.item]
        
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: data)
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data = imageList.results![indexPath.item].urls.full
        didSelectItemHandler?(data)
        dismiss(animated: true)
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let size = UIScreen.main.bounds.width - 40 //self.frame.width
        layout.itemSize = CGSize(width: size / 4, height: size / 4)
        return layout
    }
}
