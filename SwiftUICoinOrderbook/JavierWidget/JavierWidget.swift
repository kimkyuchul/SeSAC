//
//  JavierWidget.swift
//  JavierWidget
//
//  Created by 김규철 on 2023/11/30.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct JavierWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
        
        HStack {
            // URL destination
            Link(destination: URL(string: "History")!) {
                Image(systemName: "book")
                    .frame(width: 30, height: 30)
                    .background(Color.white.opacity(0.3))
                    .clipShape(Circle())
            }
            Link(destination: URL(string: "Favorite")!) {
                Image(systemName: "star")
                    .frame(width: 30, height: 30)
                    .background(Color.white.opacity(0.3))
                    .clipShape(Circle())
            }
        }
    }
}

struct JavierWidget: Widget {
    let kind: String = "JavierWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            JavierWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("위젯 링크 테스트")
        .description("This is an widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct JavierWidget_Previews: PreviewProvider {
    static var previews: some View {
        JavierWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
