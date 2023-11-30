//
//  HorizontalData.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/27.
//

import Foundation

struct HorizontalData {
    let id = UUID()
    let data: String
    let point = Int.random(in: 10...5001)
}
