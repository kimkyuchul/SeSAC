//
//  NewSimpleCollectionViewController.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/14.
//

import UIKit

final class NewSimpleCollectionViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case first = 2000
        case second = 1
    }
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    //    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, User>!
    
    var viewModel = NewSimpleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        configureDataSource()
        //        updateSnapshot()
        //
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        //            self.list.insert(User(name: "뽀로로", age: 141), at: 2)
        //            self.updateSnapshot()
        
        viewModel.list.bind { _ in
            self.updateSnapshot()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.append()
            self.updateSnapshot()
        }
    }
    
    // collectionView를 lazy로 줘도댐
    // private 은닉화
    static private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemBlue
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func updateSnapshot() {
        // UICollectionViewDiffableDataSource<Int, User>!와 타입이 동일해야 한다.
        // numberofrowinsection을 대체로 쓴다고 생각하자.
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        // 섹션의 수
        // 인덱스 기반이 아니기 때문에 다른 숫자를 넣어도 상관 없다.
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(viewModel.list.value, toSection: Section.second)
        snapshot.appendItems(viewModel.list2, toSection: Section.first)
        
        dataSource.apply(snapshot)
    }
    
    private func configureDataSource() {
        
        // UICollectionView.CellRegistraion iOS 14, register 메서드 eotls 제네릭을 사용, 셀이 생성될 때마다 클로저가 호출
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, User>(handler: { cell, indexPath, itemIdentifier in
            // 셀 디자인 및 데이터 처리
            //            content.text = itemIdentifier.name
            
            // Value of type 'UICollectionViewCell' has no member 'defaultContentConfiguration'
            // UICollectionView.CellRegistration<UICollectionViewListCell, User>!로 구현했기 때문
            //            var content = cell.defaultContentConfiguration()
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.textProperties.color = .brown
            content.secondaryText = "\(itemIdentifier.age)"
            content.image = UIImage(systemName: "star.fill")
            content.imageProperties.tintColor = .systemPink
            content.imageToTextPadding = 20
            content.prefersSideBySideTextAndSecondaryText = false //secondaryText이 오른쪽에 있는데, title 아래로
            content.textToSecondaryTextVerticalPadding = 30
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .lightGray
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 2
            backgroundConfig.strokeColor = .magenta
            cell.backgroundConfiguration = backgroundConfig
        })
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
            
        })
    }
}

extension NewSimpleCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.insertUser(name: searchBar.text!)
    }
}


extension NewSimpleCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        viewModel.removeUser(idx: indexPath.item)
        
        guard let user = dataSource.itemIdentifier(for: indexPath) else {
            return  
        }
        
        dump(user)
    }
}


//extension NewSimpleCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
//        return cell
//    }
//}


