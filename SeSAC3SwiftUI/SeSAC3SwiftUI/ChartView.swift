//
//  ChartView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/17.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    let movie: [Movie]
    
    @Environment(\.colorScheme) var color
    
    @ViewBuilder
    var chartTitle: some View {
        if color == .dark {
            HStack {
                Image(systemName: "star")
                Text("다크")
            }
        } else {
            Text("라이트")
        }
    }
    
    var body: some View {
        VStack {
            chartTitle
            Chart(movie, id: \.self) { item in
//                BarMark(
//                RectangleMark(
//                LineMark(
                AreaMark(
                    x: .value("장르", item.name),
                    y: .value("관람횟수", item.count)
                )
                .foregroundStyle(Color.random())
            }
            .frame(height: 200)
        }
        .padding()
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(movie: [
            Movie(name: "aa"),
            Movie(name: "bb"),
            Movie(name: "cc"),
            Movie(name: "cac"),
            Movie(name: "c2c")
        ])
    }
}
