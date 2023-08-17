//
//  Alert+.swift
//  SeSAC3Week5
//
//  Created by 김규철 on 2023/08/17.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, button: String, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: button, style: .default) { action in
            print("action", action.title)
            completionHandler()
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        
        alert.addAction(cancel)
        alert.addAction(button)
        
        self.present(alert, animated: true)
    }
}
