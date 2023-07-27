//
//  DoitTableViewController.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/27.
//

import UIKit

class DoitTableViewController: UITableViewController {
    
    let studyList = [
        "열거형",
        "우리형",
        "변수",
        "상수",
        "정상수",
        "삼다수",
        "무리수",
        "박명수",
    ]
    
    let iosDevices = [
        "iPhone 13",
        "iPhone 13 mini",
        "iPhone 13 Pro",
        "iPhone 13 Pro Max",
        "iPhone 12",
        "iPhone 12 mini",
        "iPhone 12 Pro",
        "iPhone 12 Pro Max",
        "iPhone SE (2nd generation)",
        "iPhone 11",
        "iPhone 11 Pro",
        "iPhone 11 Pro Max",
        "iPhone XR",
        "iPhone XS",
        "iPhone XS Max",
        "iPhone X",
        "iPhone 8",
        "iPhone 8 Plus",
        "iPhone 7",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
    }

    // MARK: - Table view data source
    
    // default 1
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "study" : "iosDevices"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? studyList.count : iosDevices.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "doitCell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = studyList[indexPath.row]
        } else {
            cell.textLabel?.text = iosDevices[indexPath.row]
        }

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return 40
//        } else {
//            return 150
//        }
//    }

}
