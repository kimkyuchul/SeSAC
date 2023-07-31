//
//  Array+.swift
//  BOOKWARM
//
//  Created by 김규철 on 2023/07/31.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
