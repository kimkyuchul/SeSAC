//
//  TodoTableViewController.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/27.
//

import UIKit

class TodoTableViewController: UITableViewController {
    
    private var list = ["밥먹기", "잠자기", "밥먹", "기", "ㅁ기", "가기", "기ㅁㅇ", "기ㅁㄴㅇ"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        self.showAlert()
        self.list.append("aa")
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    // 섹션 내의 셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    
    // 셀 디자인 및 데이터 처리 : 카톡 프로필 모서리 둥글게
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(#function)
        print(indexPath)
        
        //Identifier에 맞는 셀이 있을 수 있기 때문에 옵셔널로 반환
         let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell")!
        cell.backgroundColor = indexPath.row % 2 == 0 ? .lightGray : .orange
    
        cell.textLabel?.text = list[indexPath.row]
        
        cell.textLabel?.textColor = .red
        cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        
        cell .detailTextLabel?.text = "많이 배고파"
        cell.detailTextLabel?.textColor = .blue
        cell.detailTextLabel?.font = .systemFont(ofSize: 10)
        
        cell.imageView?.image = UIImage(systemName: "star.fill")
        
        return cell
    }
    
    // 셀의 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
