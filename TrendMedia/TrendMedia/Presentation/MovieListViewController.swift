//
//  MovieListViewController.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/11.
//

import UIKit

import SnapKit

enum TrandType: String {
    case movie = "movie"
    case tv = "tv"
    case people = "people"
}

final class MovieListViewController: BaseViewController {
    
    private var data: [TrandData] = [] {
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
        collectionView.register(TrandTVListCollectionViewCell.self, forCellWithReuseIdentifier: TrandTVListCollectionViewCell.identifier)
        collectionView.register(TrandPeopleListCollectionViewCell.self, forCellWithReuseIdentifier: TrandPeopleListCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovie()
        self.title = "Tranding 리스트"
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
        let data = data[indexPath.item]
        let type = data.mediaType
        
        if case TrandType.movie.rawValue = type {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
            cell.movieConfigureCell(row: data)
            return cell
        } else if case TrandType.tv.rawValue = type {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrandTVListCollectionViewCell.identifier, for: indexPath) as? TrandTVListCollectionViewCell else { return UICollectionViewCell() }
            cell.tvConfigureCell(row: data)
            return cell
        } else if case TrandType.people.rawValue = type {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrandPeopleListCollectionViewCell.identifier, for: indexPath) as? TrandPeopleListCollectionViewCell else { return UICollectionViewCell() }
            cell.peopleConfigureCell(row: data)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = data[indexPath.item]
        let vc = MovieDetailViewController()
        vc.detailData = data
        
        if case TrandType.movie.rawValue = data.mediaType {
            fetchCredit(movieId: data.id) { data in
                vc.creditList = data.cast
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MovieListViewController {
    func fetchMovie() {
        BaseService.shared.request(target: MovieAPI.getTrandAPI, Trand.self) { result in
            switch result {
            case .success(let data):
                self.data = data.results
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCredit(movieId: Int, completion: @escaping (Credit) -> Void)  {
        BaseService.shared.request(target: MovieAPI.getCreditsAPI(movieId: movieId), Credit.self) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
