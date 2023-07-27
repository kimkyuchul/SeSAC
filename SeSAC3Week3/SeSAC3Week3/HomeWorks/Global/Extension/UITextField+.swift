//
//  UITextField+.swift
//  SeSAC3Week3
//
//  Created by 김규철 on 2023/07/27.
//

import UIKit

extension UITextField {
    func addRightViewButton(button: UIButton) {
            self.rightView = button
            self.rightViewMode = .always
        }
}
