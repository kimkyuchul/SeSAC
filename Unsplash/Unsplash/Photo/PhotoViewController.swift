//
//  PhotoViewController.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/12.
//

import UIKit
import SnapKit

final class PhotoViewController: UIViewController {

    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var photoTableView: UITableView!
    
    private var viewModel = PhotoViewModel()
    
    var dataSource: UICollectionViewDiffableDataSource<Int, PhotoResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        photoTableView.delegate = self
//        photoTableView.dataSource = self
//        photoTableView.rowHeight = 100
//        photoTableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "PhotoTableViewCell")
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        viewModel.fetchPhoto(query: "travis")
        
        viewModel.list.bind { [weak self] photo in
            DispatchQueue.main.async {
                self?.updateSnapshot(data: photo)
            }
        }
        
        photoCollectionView.collectionViewLayout = createLayout()
        configureDataSource()
    }
    
    private func updateSnapshot(data: Photo) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, PhotoResult>()
        snapShot.appendSections([0])
        snapShot.appendItems(data.results!)
        dataSource.apply(snapShot)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemBlue
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, PhotoResult> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.likes)"
            
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.thumb)!
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: photoCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}

extension PhotoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchPhoto(query: searchBar.searchTextField.text!)
    }
}


//extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.numberOfRowsInSection
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
//        let data = viewModel.cellForRowAtPhoto(at: indexPath)
//        cell.diaryImageView.setImageFromStringURL(stringUrl: data.urls.thumb)
//        cell.titleLabel.text = data.user.username
//        cell.dateLabel.text = data.created_at
//        cell.contentLabel.text = data.description
//        return cell
//    }
//}
