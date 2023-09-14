//
//  NewSimpleCollectionViewController.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/14.
//

import UIKit

final class NewSimpleCollectionViewController: UIViewController {
    
    var list = [User(name: "kyuchul", age: 23), User(name: "hue", age: 23), User(name: "jack", age: 60)]
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // UICollectionView.CellRegistraion iOS 14, register 메서드 eotls 제네릭을 사용, 셀이 생성될 때마다 클로저가 호출
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
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
    }
    
    // collectionView를 lazy로 줘도댐
    static func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemBlue
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}

extension NewSimpleCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
        return cell
    }
    
    
}


