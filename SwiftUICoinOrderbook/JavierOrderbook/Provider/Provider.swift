//
//  Provider.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/30.
//

import WidgetKit

// 위젯의 정책
struct Provider: TimelineProvider {
    
    typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
        // 실제 랜더링 전 Default Data
        // 스켈레톤 뷰 렌더링
        // 위젯킷이 최초로 랜더링 될 때 사용
        SimpleEntry(date: Date(), test: "Jack", token: "토큰", price: 150000)
    }

    // 위젯 갤러리 미리보기 화면
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), test: "Hue", token: "비트코인", price: 151)
        completion(entry)
    }
    
    // 위젯 상태 변경 시점
    // @escaping (Timeline<Entry>) -> () -> associatedtype 이기 때문에 타입 설정이 필요하다.
    // 1. @escaping (Timeline<SimpleEntry>)
    // 2. typealias Entry = SimpleEntry
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: Date(), test: "SeSAC", token: "토큰", price: .random(in: 100...10000))
            entries.append(entry)
        }
        
        // 타임라인 마지막 날짜가 지난 뒤, 위젯킷이 새로운 타임라인을 요청
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}


