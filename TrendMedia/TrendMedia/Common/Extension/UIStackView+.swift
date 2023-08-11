//
//  UIStackView+.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/11.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
