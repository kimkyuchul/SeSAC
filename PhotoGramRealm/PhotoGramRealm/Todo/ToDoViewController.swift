//
//  ToDoViewController.swift
//  PhotoGramRealm
//
//  Created by 김규철 on 2023/09/08.
//

import UIKit
import RealmSwift

final class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let realm = try! Realm()
    
    let tableView = UITableView()
    
    var list: Results<DetailTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = toDoTable(title: "영화보자", favorite: false)
        
        let memo = Memo()
        memo.content = "주말에 팝콘 먹으면서 영화 보기"
        memo.date = Date()
        
        data.memo = memo
        
        try! realm.write {
            realm.add(data)
        }
        
//        let data = toDoTable(title: "장보기", favorite: true)
//
//        let detail1 = DetailTable(detail: "맘먹기", deadline: Date())
//        let detail2 = DetailTable(detail: "didvk", deadline: Date())
//        let detail3 = DetailTable(detail: "고구마", deadline: Date())
//
//        data.detail.append(detail1)
//        data.detail.append(detail2)
//        data.detail.append(detail3)
//
//        try! realm.write {
//            realm.add(data)
//        }
        
        print(realm.configuration.fileURL)
        
        self.view.backgroundColor = .systemPink
        
        list = realm.objects(DetailTable.self)
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoCell")
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell")!
//        cell.textLabel?.text = "\(list[indexPath.row].title): \(list[indexPath.row].detail.count)개 \(list[indexPath.row].memo?.content)"
        
        let data = list[indexPath.row]
        
        cell.textLabel?.text = "\(data.detail) in \(data.mainTodo.first?.title ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        
        // list의 detail table은 제거되지 않음
//        try! realm.write {
//            // detail을 먼저 제거해야한다. -> data를 먼저 제거하면 detail 찾을 수 없음
//            realm.delete(data.detail)
//            realm.delete(data)
//        }
//
//        tableView.reloadData()
    }
    
    func createDetail() {
        print(realm.configuration.fileURL)
        
        // Todo 테이블 데이터 추가
//        createTodo()
        
        // Todo 테이블의 필터링한 컬럼 1개
        let main = realm.objects(toDoTable.self).where {
            $0.title == "장보기"
        }.first!
        
        for i in 1...10 {
            let detailTodo = DetailTable(detail: "장보기 세부 할일 \(i)", deadline: Date())
            
            try! realm.write {
//                realm.add(detailTodo)
                main.detail.append(detailTodo)
            }
        }

    }
    
    func createTodo() {
        for i in ["장보기", "영화보기", "리캡보기", "리캡하기", "밥먹기", "똥싸기", "포기하지말기"] {
            
            let data = toDoTable(title: i, favorite: false)
            
            try! realm.write {
                realm.add(data)
            }
        }
    }
}

