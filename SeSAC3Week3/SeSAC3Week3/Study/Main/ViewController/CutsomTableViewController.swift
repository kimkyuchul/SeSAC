//
//  CutsomTableViewController.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/28.
//

import UIKit


final class CutsomTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var todo = toDoInfo() {
        didSet { //변수가 달라짐을 감지!
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        
        searchBar.placeholder = "할일을 입력해보라게"
        searchBar.searchTextField.addTarget(self, action: #selector(searchBarReturnTapped), for: .editingDidEndOnExit)

    }
    
    @objc func searchBarReturnTapped() {
        view.endEditing(true)
        guard let text = searchBar.searchTextField.text else { return }
        todo.list.append(ToDo(main: text, sub: text, like: true, done: false))
        //todo.list.insert(data, at: 0)
        searchBar.searchTextField.text = nil
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todo.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell

        let row = todo.list[indexPath.row]
        
        cell.configureCell(todo: row)
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        print(cell.likeButton.tag)

        return cell
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        print("\(sender.tag)")
        
//        todo.list[indexPath.row].like
        todo.list[sender.tag].like.toggle()
        
//        tableView.reloadRows(at: [sender.tag], with: .automatic)

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)")
    }
    
    
    //삭제
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //제거 -> 갱신
        todo.list.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}
