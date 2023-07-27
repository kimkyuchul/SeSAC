//
//  Extension.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/27.
//

import UIKit

extension UIViewController {
    
    func showAlert() {
        let alert = UIAlertController(title: "추가 되었어요.", message: "굿", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "닫기", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}


