//
//  SearchView.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/28.
//

import UIKit

class SearchView: BaseView {
    
    let searchBar = {
        let view = UISearchBar()
        view.placeholder = "검색어를 입력해주세요"
        return view
    }()
    
    // self.frame.width을 사용하기 위해 init 타이밍을 늦춤
    lazy var collectionView = {
        // UICollectionView must need UICollectionFlowLayout
        // 코드로 초기화 시 레이아웃이 디폴트로 init
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        return view
    }()
    
    override func configureView() {
        super.configureView()
        addSubview(searchBar)
        addSubview(collectionView)
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
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 9
//        let size = self.frame.width - 40
        let size = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: size / 4, height: size / 4)
        return layout
    }
}
