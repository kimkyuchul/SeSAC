//
//  SettingTableViewController.swift
//  OneLineDiary
//
//  Created by 김규철 on 2023/08/01.
//

import UIKit

enum SettingOptions: Int, CaseIterable {
    case first
    case second
    case others
    
    var mainOptions: String {
        switch self {
       // get만 사용하면 get은 생략 가능
        case .first:
            return "전체 설정"
        case .second:
            return "개인 설정"
        case .others:
            return "기타"
        }
    }
    
    var subOptions: [String] {
        switch self {
        case .first:
            return ["공지사항", "실험실", "버전 정보"]
        case .second:
            return ["공지사항", "실험실", "버전 정보", "ㅁㅁㄴㅇㅁㅇㅁㄴ"]
        case .others:
            return ["공지사항"]
        }
    }
    
    
}

class SettingTableViewController: UITableViewController {
    
    let first = ["공지사항", "실험실", "버전 정보"]
    let second = ["공지사항", "실험실", "버전 정보", "ㅁㅁㄴㅇㅁㅇㅁㄴ"]
    let third = ["공지사항"]
    
    let list = [
        ["공지사항", "실험실", "버전 정보"],
        ["공지사항", "실험실", "버전 정보", "ㅁㅁㄴㅇㅁㅇㅁㄴ"],
        ["공지사항",]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return SettingOptions.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SettingOptions.allCases[section].subOptions.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingOptions.allCases[section].mainOptions
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)

        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].subOptions[indexPath.row]
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
