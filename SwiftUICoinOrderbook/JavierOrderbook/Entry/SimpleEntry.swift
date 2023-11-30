//
//  SimpleEntry.swift
//  JavierOrderbookExtension
//
//  Created by 김규철 on 2023/11/30.
//

import WidgetKit

// 위젯을 구성하는 데 필요한 Data
struct SimpleEntry: TimelineEntry {
    let date: Date
    let test: String
    let token: String
    let price: Int
}
