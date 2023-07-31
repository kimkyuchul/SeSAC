//
//  BookListCollectionViewController.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/07/31.
//

import UIKit

enum Metric {
    static let inset: CGFloat = 20.0
}

final class BookListCollectionViewController: BaseCollectionViewController {
    
    private var viewModel: MovieListViewModel!
        
    private var movieList: [Movie] = []
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            viewModel = MovieListViewModel()
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "김규철의 책장"
        bind()
        viewModel.viewDidLoad()
    }
    
    override func setCollectionView() {
        super.setCollectionView()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = Metric.inset
        flowLayout.minimumLineSpacing = Metric.inset
        flowLayout.sectionInset = UIEdgeInsets(top: Metric.inset, left: Metric.inset, bottom: Metric.inset, right: Metric.inset)
        let size:CGFloat = (collectionView.getDeviceWidth() - (Metric.inset * 3))
        flowLayout.itemSize = CGSize(width: size / 2, height: size / 2)
        collectionView.collectionViewLayout = flowLayout
    }
    
    override func setRegister() {
        let nib = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
    }
    
    override func setLayout() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.searchButtonImage, style: .done, target: self, action: #selector(searchBarButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func searchBarButtonTapped(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SearchViewController")
        let nvc = UINavigationController(rootViewController: vc)
        nvc.modalTransitionStyle = .coverVertical
        nvc.modalPresentationStyle = .fullScreen
        present(nvc, animated: true)
    }
    
    private func bind() {
           viewModel.getMovieObservar = { [weak self] in
               guard let self = self else { return }
               self.movieList = self.viewModel.movie ?? self.movieList
           }
       }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
    
        let row = self.movieList[indexPath.row]
        
        cell.configureCell(row: row)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        vc.title = movieList[indexPath.row].title
        navigationController?.pushViewController(vc, animated: true)
    }

}
