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
    
    private let searchBar = UISearchBar()
    
    private var viewModel: MovieListViewModel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel = MovieListViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "김규철의 책장"
        bind()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
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
        
        navigationItem.titleView = searchBar
        searchBar.placeholder = "검색어를 입력"
        searchBar.showsCancelButton = true
    }
    
    @objc func searchBarButtonTapped(_ sender: UIBarButtonItem) {
        
        guard let queryData = searchBar.text, !queryData.isEmpty else {
            print("에러")
            return }
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        vc.viewModel.query = queryData
        let nvc = UINavigationController(rootViewController: vc)
        nvc.modalTransitionStyle = .coverVertical
        nvc.modalPresentationStyle = .fullScreen
        present(nvc, animated: true)
        
    }
    
    private func bind() {
        viewModel.getMovieObservar = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.isFiltering ? self.viewModel.searchList.count : self.viewModel.movie.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
        
        var row = self.viewModel.movie[indexPath.row]
        
        if viewModel.isFiltering {
            row = self.viewModel.searchList[indexPath.row]
        }
        
        cell.likeButtonAction = { [weak self] in
            self?.viewModel.likeButtonTapped(indexPath: indexPath)
            DispatchQueue.main.async {
                collectionView.reloadItems(at: [indexPath])
            }
        }
        
        cell.configureCell(row: row)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        vc.title = viewModel.movie[indexPath.row].title
        vc.viewModel.movie = self.viewModel.movie[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension BookListCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.isFiltering = true
        
        if let text = searchBar.text {
            viewModel.searchText(text: text)
        }
        
        self.collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.isFiltering = true
        
        if let text = searchBar.text {
            viewModel.searchText(text: text)
        }
        
        self.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.isFiltering = false
        
        self.collectionView.reloadData()
    }
}
