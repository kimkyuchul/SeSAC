//
//  MovieListViewController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/11.
//

import UIKit

import SnapKit

final class MovieListViewController: BaseViewController {
    
    private lazy var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .magenta
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setHierarchy() {
        view.addSubview(movieCollectionView)
    }
    
    override func setConstraints() {
        movieCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setLayout() {
        super.setLayout()
    }

}
