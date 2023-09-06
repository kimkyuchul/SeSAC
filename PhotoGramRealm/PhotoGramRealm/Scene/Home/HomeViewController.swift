//
//  HomeViewController.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit
import SnapKit
import RealmSwift

class HomeViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 100
        view.delegate = self
        view.dataSource = self
        view.register(PhotoListTableViewCell.self, forCellReuseIdentifier: PhotoListTableViewCell.reuseIdentifier)
        return view
    }()
     
    // 알아서 데이터를 갱신해주기 때문에 viewWillAppear에서 object를 부를 필요가 없이 viewDidLoad에서 한번만 호출해두면 된다. -> 뷰 리로드만 해주면 됨
    var tasks: Results<DiaryTable>!
    //Realm Read
    let realm = try! Realm()
    
    let repositoty = DiaryTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Access all dogs in the realm
        // byKeyPath 기준으로 정렬 ascending: false -> 내림차순, true -> 오름차순
//        tasks = realm.objects(DiaryTable.self).sorted(byKeyPath: "diaryTitle", ascending: true)
        repositoty.checkSchemaVersion()
        tasks = repositoty.fetch(DiaryTable.self)
        
        print(tasks)
        
//        레포지토리로 이동시키기
//        print(realm.configuration.fileURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func configure() {
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        let backupButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton, backupButton]
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func plusButtonClicked() {
        navigationController?.pushViewController(AddViewController(), animated: true)
    }
    
    @objc func backupButtonClicked() {
        
    }
    
    
    @objc func sortButtonClicked() {
        
    }
    
    @objc func filterButtonClicked() {
       
//        let result = realm.objects(DiaryTable.self).where {
//            // caseInsensitive -> 대소문자 구별 없음
////            $0.diaryTitle.contains("제목", options: .caseInsensitive)
//
//            //2. bool
////            $0.diaryLike == true
//
//            //3. 사잔이 있는 데이터만 불러오기 nil 여부 판단
//            $0.diaryPhoto != nil
//
//        }
        
        tasks = repositoty.fetchDiaryPhotoFilter()
        
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoListTableViewCell.reuseIdentifier) as? PhotoListTableViewCell else { return UITableViewCell() }
        
        let data = tasks[indexPath.row]
        
        cell.titleLabel.text = data.diaryTitle
        cell.contentLabel.text = data.contents
        cell.dateLabel.text = "\(data.diaryDate)"
        
        
        // String -> URL -> Data -> UIImage
        // Realm은 메인스레드에서 동작
//        let url = URL(string: data.diaryPhoto ?? "")
//
//        // 1. 셀 서버 통신은 용량이 크다면 로드가 오래 걸림
//        // 2. 이미지를 미리 UIImage 형식으로 변환하고, 셀에서 UIImage를 바로 보여주자.
//        // => 재사용 매커니즘을 효율적으로 사용하지 못할 것, => UIImage 배열 구성 자체가 오래 걸림
//        DispatchQueue.global().async {
//            if let url = url, let data = try? Data(contentsOf: url ) {
//                DispatchQueue.main.async {
//                    cell.diaryImageView.image = UIImage(data: data)
//                }
//            }
//        }
        
        cell.diaryImageView.image = loadImageFromDocument(fileName: "\(data._id).jpg")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Realm Delete
        let data = tasks[indexPath.row]
        
//        removeImageFromDocument(fileName: "\(data._id).jpg")
//
//        // realm만 지우지말고 도큐먼트 내의 사진 데이터도 직접 삭제해야 한다.
//        try! realm.write {
//            realm.delete(data)
//        }
//
//        tableView.reloadData()
        
        let vc = DetailViewController()
        vc.data = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let likeAction = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            print("좋아요.")
        }
        
        let sampleAction = UIContextualAction(style: .normal, title: "샘플") { action, view, completionHandler in
            print("좋아요 샘플.")
        }
        
        likeAction.backgroundColor = .orange
        likeAction.image = tasks[indexPath.row].diaryLike ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        
        return UISwipeActionsConfiguration(actions: [likeAction, sampleAction])
    }
}
