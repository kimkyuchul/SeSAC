//
//  SettingTableViewController.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/27.
//

import UIKit

final class SettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "설정"
        setTableView()
    }
    
    private func setTableView() {
        self.tableView.backgroundColor = .tertiarySystemBackground
        self.tableView.rowHeight = 60
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingType.allCases[section].rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingType.allCases[section].numberOfRowsInSection
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
        cell.textLabel?.text = SettingType.allCases[indexPath.section].item[indexPath.row]

        return cell
    }
}
