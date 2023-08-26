//
//  MovieListViewController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/11.
//

import UIKit

import SnapKit
final class MovieListViewController: BaseViewController {
    
    private var data: [MovieDetail] = [] {
        didSet {
            movieCollectionView.reloadData()
        }
    }
    
    private lazy var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.getDeviceWidth(), height: view.getDeviceHeight() * 0.6)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .tertiarySystemGroupedBackground
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovie()
        self.title = "영화 리스트"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .tertiarySystemGroupedBackground
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

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        cell.movieConfigureCell(row: data[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.detailData = data[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MovieListViewController {
    func fetchMovie() {
        BaseService.shared.request(target: MovieAPI.getTrandAPI, Movie.self) { result in
            switch result {
            case .success(let data):
                self.data = data.results
            case .failure(let error):
                print(error)
            }
        }
    }
}
