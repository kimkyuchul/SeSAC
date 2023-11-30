//
//  JavierOrderbook.swift
//  JavierOrderbook
//
//  Created by 김규철 on 2023/11/29.
//

import WidgetKit
import SwiftUI

struct JavierOrderbook: Widget {
    // 위젯에 대한 종류
    // 위젯 고유한 문자열
    let kind: String = "JavierOrderbook"

    var body: some WidgetConfiguration {
        // StaticConfiguration -> 위젯 편집이 불가능
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            JavierOrderbookEntryView(entry: entry)
//                 iOS 17 +
//                .containerBackground
        }
        .configurationDisplayName("보유 코인")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

//struct JavierOrderbook_Previews: PreviewProvider {
//    static var previews: some View {
//        JavierOrderbookEntryView(entry: SimpleEntry(date: Date()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
