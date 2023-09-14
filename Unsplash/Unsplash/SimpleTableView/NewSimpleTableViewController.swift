//
//  NewSimpleTableViewController.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/14.
//

import UIKit

class NewSimpleTableViewController: UITableViewController {
    
    var list = [User(name: "kyuchul", age: 23), User(name: "hue", age: 23), User(name: "jack", age: 60)]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = list[indexPath.row].name
        content.secondaryText = "\(list[indexPath.row].age)"
        content.imageToTextPadding = 2
        cell.contentConfiguration = content
        return cell
    }
}
