//
//  UIVIewController+.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/18.
//

import UIKit

extension UIViewController {
    func errorPresentAlert(type: ErrorAlertType) {
        let alert = UIAlertController(title: type.title, message: type.description, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: type.buttonTitle, style: .default, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
