//
//  CustomTableViewController.swift
//  SeSAC3Week6
//
//  Created by 김규철 on 2023/08/24.
//

import UIKit

import SnapKit

struct Sample {
    let text: String
    var isExpand: Bool
}

class CustomTableViewController: UIViewController {
    
//    var isExpand = false
    
    var list = [Sample(text: "UIViewControllerUIViewControllerUIViewControllerUIViewControllerUIViewControllerUIViewController", isExpand: false),Sample(text: "UIViewControllerUIViewControllerUIViewControllerUIViewControllerUIViewControllerUIViewController", isExpand: false),Sample(text: "UIViewControllerUIViewControllerUIViewControllerUIViewControllerUIViewControllerUIViewController", isExpand: false),Sample(text: "UIViewControllerUIViewControllerUIViewController", isExpand: false),Sample(text: "UIViewControllerontroller", isExpand: false),Sample(text: "UIViewControllerUIViewControllerUIViewControllerUIViewControllerUIViewControllerUIViewController", isExpand: false)]
    
    // viewDidLoad보다 클로저 구문이 먼저 실행
    // CustomTableViewController 인스턴스 생성 직전에 클로저 구문이 우선 실행
    private lazy var tableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        view.delegate = self // 자기 자신의 인스턴스
        view.dataSource = self
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        return view
    }()
    
    let imageView = {
        // frame: .zero와 CGRECT(0000)은 같은 것
//        let v = CustomImageView(frame: .zero)
        let v = CustomImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            print("")
            make.size.equalTo(200)
            make.center.equalTo(view)
        }
    }
}

extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.label.text = list[indexPath.row].text
        cell.label.numberOfLines = list[indexPath.row].isExpand ? 2 : 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        isExpand.toggle()
//        tableView.reloadData()
        list[indexPath.row].isExpand.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
