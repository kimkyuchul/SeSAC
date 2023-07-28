//
//  ShoppingViewController.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/27.
//

import UIKit

final class ShoppingViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.titleLabel?.tintColor = .black
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .tertiarySystemFill
        tableView.rowHeight = 60
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ShoppingTableViewCell.self, forCellReuseIdentifier: ShoppingTableViewCell.CellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "쇼핑"
        setTextField()
        setTableView()
    }
    
    @objc func buttonTapped() {
        view.endEditing(true)
        if let text = textField.text {
            ShoppingManager.shoppingList.append(text)
            self.tableView.reloadData()
        }
        self.showAlert()
    }
    
    private func setTextField() {
        textField.addRightViewButton(button: button)
        textField.placeholder = "무엇을 구매할건가?"
        textField.backgroundColor = .systemGroupedBackground
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true
    }
    
    private func setTableView() {
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ShoppingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ShoppingManager.shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.CellIdentifier, for: indexPath) as? ShoppingTableViewCell else { return UITableViewCell() }
        cell.setLayout(title:  ShoppingManager.shoppingList[indexPath.row])
        
        return cell
    }
}
