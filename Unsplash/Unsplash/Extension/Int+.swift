//
//  Int+.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/13.
//

import Foundation


extension Int {
    var format: String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        return numberFormat.string(for: self)!
    }
}
