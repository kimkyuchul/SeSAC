//
//  RealmCollectionViewController.swift
//  PhotoGramRealm
//
//  Created by 김규철 on 2023/09/14.
//

import UIKit

import RealmSwift

final class RealmCollectionViewController: BaseViewController {
    
    let realm = try! Realm()
        
    // UICollectionView() 코드 베이스 시 프레임과 레이아웃 설정 필수 필요
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    // 셀의 디자인, UICollectionViewListCell: 애플의 셀 형식이 정해진 디폴트 셀
    // CellRegistration 제네릭의 두번째 파라미터는 리스트의 indexPath.row의 타입이 들어가야 한다.
    var cellRegisteration: UICollectionView.CellRegistration<UICollectionViewListCell, toDoTable>!

    private var list: Results<toDoTable>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = realm.objects(toDoTable.self)
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cellRegisteration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.image = itemIdentifier.favorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            content.text = itemIdentifier.title
            content.secondaryText = "\(itemIdentifier.detail.count)개의 세부 할일"
            cell.contentConfiguration = content
        })
    }
    
    static func layout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}

extension RealmCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let data = list[indexPath.row]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: data)
        return cell
    }
}
