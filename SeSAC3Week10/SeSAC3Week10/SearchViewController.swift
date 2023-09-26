//
//  SearchViewController.swift
//  SeSAC3Week10
//
//  Created by 김규철 on 2023/09/21.
//

import UIKit
import Kingfisher

final class SearchViewController: UIViewController, UISearchBarDelegate {
    
    private let list = Array(0...100)
    
    private let realList = ["이모티콘", "새싹", "추석", "햄버거", "컬렉션뷰레이아웃", "UICollectionViewDiffableDataSource"]
    
    // var collectionView 인스턴스 프로퍼티, func configureCollectionView() 인스턴스 메서드
    // 인스턴스가 사용되는 시점에 호출 collectionView를 생성하려면 configureCollectionView() 이미 호출 생성되어 있어야 한다.
    // 똑같은 시점에 생성이 되기 때문에 lazy 필요
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configurePinterrestLayout())
    
    // <SectionIdentifierType, ItemIdentifierType>
    // 이 클래스를 상속받아서 서브클래스를 만들어서 사용하자.
    // preconcurrency @MainActor open class UICollectionViewDiffableDataSource<SectionIdentifierType, ItemIdentifierType>
    var dataSource: UICollectionViewDiffableDataSource<Int, PhotoResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureDataSource()
//        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        let bar = UISearchBar()
        bar.delegate = self
        navigationItem.titleView = bar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Network.shared.request(type: Photo.self, api: .search(query: searchBar.text!)) { [weak self] result in
            switch result {
            case .success(let success):
                let ratios = success.results.map { Ratio(ratio: $0.width / $0.height) }
                
                let layout = PinterestLayout(columnsCount: 2, itemRatios: ratios, spacing: 10, contentWidth: self?.view.frame.width ?? 0)
                
                self?.collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: layout.section)
                self?.configureSnapshot(items: success.results) // 레이아웃 지정 이후 스냅샷
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func configureSnapshot(items: [PhotoResult]) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, PhotoResult>()
        snapShot.appendSections([0]) // like numberOfSection
        snapShot.appendItems(items) // like numberOfItemsInSection
        dataSource.apply(snapShot)
    }

    func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
//        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureDataSource() {
        
        // public struct CellRegistration<Cell, Item> where Cell : UICollectionViewCell
        let cellRegistration = UICollectionView.CellRegistration<SearchCollectionViewCell, PhotoResult> { cell, indexPath, itemIdentifier in
            // cell design
            cell.imageView.kf.setImage(with: URL(string: itemIdentifier.urls.thumb)!)
            cell.label.text = "\(itemIdentifier.created_at) itemIdentifier"
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }
    
    
    func configurePinterrestLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(150))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150)) // absolute 고정값
        
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        // horizontal이기 때문에 양 옆이 10
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        // section의 상하좌우 Inset, 바깥 여백
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }
    
//    func configureCollectionView() -> UICollectionViewLayout {
//
//        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0))
//
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .absolute(30)) // absolute 고정값
//
////        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        // horizontal이기 때문에 양 옆이 10
//        group.interItemSpacing = .fixed(10)
//
//        let section = NSCollectionLayoutSection(group: group)
//        // section의 상하좌우 Inset, 바깥 여백
//        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//        section.interGroupSpacing = 10
//
//        let configuration = UICollectionViewCompositionalLayoutConfiguration()
//        configuration.scrollDirection = .vertical
//
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        layout.configuration = configuration
//
//        return layout
//    }
    
    
    
    
    // 데이터 영역에 별도 저장되는 static
    // collectionView의 lazy가 필요없어지겠죠? => lazy에 오류가 난다.
    // SearchViewController의 init, deinit의 시점에서도 static은 앱이 실행되어있을 때 계속 메모리에 남아있기 때문에 좋지 않다.
    // 만약 첫화면이라면 static func ok -> 첫화면은 계속 살아있기 때문
//    func configureCollectionView() -> UICollectionViewFlowLayout {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 50, height: 50)
//        layout.scrollDirection = .vertical
//        return layout
//    }
        
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCollectionViewCell
//        cell.label.text = "\(list[indexPath.item]) cellForItemAt"
//        return cell
//    }
}

/// 세로 스크롤 뷰
//final class SearchViewController: UIViewController {
//
//    let scrollView = UIScrollView()
//    let stackView = UIStackView()
//    let contentView = UIView()
//
//    let imageView = UIImageView()
//    let label = UILabel()
//    let button = UIButton()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = . white
//        configureHierarchy()
//        configureLayout()
//        configureContentView()
//    }
//
//    func configureContentView() {
//        [imageView, label, button].forEach {
//            scrollView.addSubview($0)
//        }
//
//        imageView.backgroundColor = .orange
//        button.backgroundColor = .magenta
//        label.backgroundColor = .systemGray
//
//        imageView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(200)
//        }
//
//        button.snp.makeConstraints { make in
//            make.bottom.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(80)
//        }
//
//        label.text = "aadasdsadadadadadad\naadasdadadadad\nasdadsad\nasdadadasdsad\nasdadadasdsd\nasdadadasdsd\nasdadadasdsd\nasdadadasdsd\nasdadadasdsd\nasdadadasdsd\nasdadadasdsd\nasdadadasdsd\nasdadadasdsnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsdnasdadadasdsd"
//        label.numberOfLines = 0
//        label.snp.makeConstraints { make in
//            make.horizontalEdges.equalTo(contentView)
//            make.top.equalTo(imageView.snp.bottom).offset(50)
//            make.bottom.equalTo(button.snp.top).offset(-50)
//        }
//    }
//
//    func configureHierarchy() {
//        scrollView.backgroundColor = .blue
//        view.addSubview(scrollView)
//        contentView.backgroundColor = .purple
//        scrollView.addSubview(contentView)
//    }
//
//    func configureLayout() {
//        scrollView.bounces = false
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//
//        // scrollView.contentLayoutGuide
//        contentView.snp.makeConstraints { make in
//            make.verticalEdges.equalTo(scrollView)
//            make.width.equalTo(scrollView.snp.width)
//        }
//    }

    
    
    
/// 가로스크롤
    
//    func configureHierarchy() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(stackView)
//    }
//
//    func configureLayout() {
//        scrollView.backgroundColor = .brown
//        scrollView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(70)
//        }
//
//        stackView.backgroundColor = .systemPink
//        stackView.spacing = 15
//        stackView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView)
//            make.height.equalTo(scrollView.snp.height)
//        }
//    }
//
//    func configureStackView() {
//        let label2 = (1...5).map { _ in
//            makeLabel()
//        }
//
//        label2.forEach { label in
//            stackView.addArrangedSubview(label)
//        }
//    }
//
//    func makeLabel() -> UILabel {
//        let label1 = UILabel()
//        label1.text = "안녕하세여 안녕하세여 안녕하세여 안녕하세여"
//        label1.textColor = .cyan
//        return label1
//    }
// }
