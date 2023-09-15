//
//  SampleViewController.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/12.
//

import UIKit

struct User: Hashable {
    let name: String
    let age: Int
    
    let unique = UUID().uuidString
    
    var introduce: String {
        return "\(name), \(age)살"
    }
}

class User1: Hashable {
    
    static func == (lhs: User1, rhs: User1) -> Bool {
        lhs.unique == rhs.unique
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(unique)
    }
    
    let name: String
    let age: Int
    
    // 고유의 값을 설정하더라도 class로 선언 시 여러 상속
    let unique = UUID().uuidString
    
    var introduce: String {
        return "\(name), \(age)살"
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

final class SampleViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = SampleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sampleCell")
    }
}

extension SampleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell")!
//        let data = viewModel.cellForRowAt(at: indexPath)
//        // 가공하는 역할을 view가 할 필요가 없다.
////        cell.textLabel?.text = "\(data.name), \(data.age)살"
//
//        cell.textLabel?.text = data.introduce
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration() // Configuration -> 거의 구조체
        content.text = "테스트" // textLabel
        content.secondaryText = "안녕하세요 \(indexPath.row)" // detailTextLabel
        cell.contentConfiguration = content //protocol as Type
        return cell
    }
}
