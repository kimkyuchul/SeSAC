//
//  UIColor+.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/08/02.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}
