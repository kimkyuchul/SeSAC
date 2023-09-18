//
//  RandimViewController.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/18.
//

import UIKit

final class RandimViewController: UIViewController {
    
    enum Section {
        case image
    }
    
    typealias CellRegistration = UICollectionView.CellRegistration<RandomCollectionViewCell, ImageInfo>
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, ImageInfo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ImageInfo>
    var dataSource: DiffableDataSource!
    
    let viewModel = RandomViewModel()
    
    private lazy var collectionView: UICollectionView = {
         let collectionView = UICollectionView(
             frame: .zero,
             collectionViewLayout: createLayout()
         )
         return collectionView
     }()
    private let reButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤입니다.", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .systemOrange
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoadEvent()
        configureLayout()
        self.view.backgroundColor = .systemPink
        configureCellRegistrationAndDataSource()
        bind()
//        RandomService.shared.searchPhoto { data in
//            print(data)
//        }
    }
    
    private func bind() {
        viewModel.randomPhotoList.bind { [weak self] data in
            self?.applyCollectionViewDataSource(by: data)
        }
    }
    
    
    func applyCollectionViewDataSource(
         by viewModels: [ImageInfo]
     ) {
         var snapshot = Snapshot()
         
         snapshot.appendSections([.image])
         snapshot.appendItems(viewModels, toSection: .image)
         
         dataSource.apply(snapshot)
     }
    
    private func configureCellRegistrationAndDataSource() {
        let ClimbingGymVideoCellRegistration = CellRegistration { cell, _, random in
            cell.imageView.setImageFromStringURL(stringUrl: random.urls.thumb)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: ClimbingGymVideoCellRegistration, for: indexPath, item: itemIdentifier)
            return cell
            
        })
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] _, _ -> NSCollectionLayoutSection? in
            return self?.createSection()
        })
        return layout
    }
    
    private func createSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(270))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section =  NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func configureLayout() {
        view.addSubview(collectionView)
        view.addSubview(reButton)
        collectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        reButton.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
