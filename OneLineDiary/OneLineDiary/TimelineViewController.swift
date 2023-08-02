//
//  TimelineViewController.swift
//  OneLineDiary
//
//  Created by 김규철 on 2023/08/02.
//

import UIKit
/*
 1. 프로토콜(ex. 부하직원): UICollectionViewDelegate, UICollectionViewDataSource
 2. 컬렉션뷰와 부하직원을 연결: delegate = self (타입으로서 프로토콜 사용)
 3. 컬렉션뷰 아웃렛
 
 */

class TimelineViewController: UIViewController {

    @IBOutlet weak var todayCollectionView: UICollectionView!
    @IBOutlet weak var bestCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todayCollectionView.delegate = self
        todayCollectionView.dataSource = self
        
        bestCollectionView.delegate = self
        bestCollectionView.dataSource = self
        
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        todayCollectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        bestCollectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        
        configureCollectionViewLayout()
        configureBestCollectionViewLayout()
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: todayCollectionView.bounds.height)
        // 콜렉션뷰와 셀 사이의 전체 여백 inset
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        todayCollectionView.collectionViewLayout = layout
    }
    
    func configureBestCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: todayCollectionView.bounds.height)
        // 콜렉션뷰와 셀 사이의 전체 여백 inset
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        bestCollectionView.collectionViewLayout = layout
        bestCollectionView.isPagingEnabled = true
        
        
    }
}

extension TimelineViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == todayCollectionView ? 5 : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        
        if collectionView == todayCollectionView {
            cell.contentLabel.text = "Today \(indexPath.item)"
            cell.backgroundColor = .lightGray
        } else {
            cell.contentLabel.text = "best \(indexPath.item)"
            cell.backgroundColor = .purple
        }
        
        return cell
    }
    
    
}
