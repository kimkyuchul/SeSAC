//
//  SearchViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/11/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SampleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        title = "\(Int.random(in: 1...100))"
    }
}

class SearchViewController: UIViewController {
     
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 200
        view.separatorStyle = .none
       return view
     }()
    
    let searchBar = UISearchBar()
     
//    var items = BehaviorSubject(value: Array(100...150).map { "안녕하세요 \($0)"})
    
//    var data = ["A", "B", "C", "adadsad", "2", "a", "x"]
    
    var data: [AppInfo] = []
    
    lazy var items = BehaviorSubject(value: data)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        setSearchController()
        bind()
        APIManager.fetchData()
        
    }
     
    func bind() {
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.appNameLabel.text = element.trackName
                cell.appIconImageView.backgroundColor = .green
                
                // 재사용 매커니즘에 따라 구독이 모두 다르다.
                cell.downloadButton.rx.tap
                    .subscribe(with: self) { owner, _ in
                        owner.navigationController?.pushViewController(SampleViewController(), animated: true)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        let request = APIManager.fetchData()
            .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
        
        //1. subscribe: share, ObserveOn
        //2. bind: share
        //3. drive:
        
//        request
//            .subscribe(with: self) { owner, result in
//                owner.items.onNext(result.results)
//            }
//            .disposed(by: disposeBag)
//
//        request
//            .map { result in
//                "\(result.results.count)개"
//            }
//            .subscribe(with: self) { owner, result in
//                owner.navigationItem.rx.title // 스레드 문제가 발생, 그리고 통신이 두번
//            }
//            .disposed(by: disposeBag)
        
        request
            .drive(with: self) { owner, result in
                owner.items.onNext(result.results)
            }
            .disposed(by: disposeBag)

        request
            .map { result in
                "\(result.results.count)개"
            }
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        
//        request
//            .map { $0.results }
//            .asDriver(onErrorJustReturn: [])
//            .drive(items)
//            .disposed(by: disposeBag)
        
//        tableView.rx.itemSelected
//            .bind(with: self) { owner, indexPath in
//                print(indexPath)
//            }
//            .disposed(by: disposeBag)
        
//        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(String.self))
//            .map { "셀 선택 \($0), \($1)" }
//            .bind(to: navigationItem.rx.title)
//            .disposed(by: disposeBag)
//
////        searchBar.rx.searchButtonClicked
////            .withLatestFrom(searchBar.rx.text.orEmpty) { _, text in
////                return text
////            }
////            .subscribe(with: self) { owner, text in
////                owner.data.insert(text, at: 0)
////                owner.items.onNext(owner.data)
////            }
////            .disposed(by: disposeBag)
//
//        searchBar.rx.text
//            .orEmpty
//            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
//            .subscribe(with: self) { owner, text in
//                let result = text == "" ? owner.data : owner.data.filter { $0.contains(text) }
//                owner.items.onNext(result)
//
//                print("==실시간 검색==")
//            }
//            .disposed(by: disposeBag)
        
    }
    
    private func setSearchController() {
        view.addSubview(searchBar)
        self.navigationItem.titleView = searchBar
    }

    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
}
