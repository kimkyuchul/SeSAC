//
//  extension.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/27.
//

import UIKit

extension UITableViewController {
    
    func showAlert() {
        let alert = UIAlertController(title: "aa", message: "bb", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "ad", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension UILabel {
    
    func titleText() {
        self.textColor = .black
    }
}
