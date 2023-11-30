//
//  EntryView.swift
//  JavierOrderbookExtension
//
//  Created by 김규철 on 2023/11/30.
//

import WidgetKit
import SwiftUI

// 위젯을 구성하는 View
struct JavierOrderbookEntryView : View {
    // Entry -> 뷰를 구성
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
        Text(entry.test)
        Text(UserDefaults.groupShared.string(forKey: "Market") ?? "코인")
        Text(entry.token)
        Text(entry.price.formatted())
    }
}
// 레이어 별 관심사가 다르기 때문에 협업 시 코드 파악이 수월해져 개발 효율을 높일 수 있었음
