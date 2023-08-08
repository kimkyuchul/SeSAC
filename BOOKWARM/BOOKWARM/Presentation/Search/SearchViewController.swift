//
//  SearchViewController.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/01.
//

import UIKit
import Kingfisher

final class SearchViewController: UIViewController {

    @IBOutlet weak var searchcollectionView: UICollectionView!
    
    var viewModel: SearchViewModel!
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            viewModel = SearchViewModel()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "찾기"
        setCollectionView()
        setLayout()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
        
    @objc func dismissTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    private func bind() {
        viewModel.getBookObservar = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.searchcollectionView.reloadData()
            }
        }
    }
    
    private func setLayout() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.xImage, style: .plain, target: self, action: #selector(dismissTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = Metric.inset
        flowLayout.minimumLineSpacing = Metric.inset
        flowLayout.sectionInset = UIEdgeInsets(top: Metric.inset, left: Metric.inset, bottom: Metric.inset, right: Metric.inset)
        let size:CGFloat = (searchcollectionView.getDeviceWidth() - (Metric.inset * 3))
        flowLayout.itemSize = CGSize(width: size / 2, height: size / 2)
        searchcollectionView.collectionViewLayout = flowLayout
        
        searchcollectionView.delegate = self
        searchcollectionView.dataSource = self
        let nib = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        searchcollectionView.register(nib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.BookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
        
        var row = self.viewModel.BookList[indexPath.row]
        
        cell.posterImageView.kf.setImage(with: URL(string: row.thumbnail))
        cell.titleLabel.text = row.title
        cell.ratingTitle.text = String(row.price)
        
        return cell
    }
    
    
    
}
