//
//  GridView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/17.
//

import SwiftUI

struct GridView: View {
    
    @Binding var movie: [Movie]
    
    @State var dummy = Array(1...100).map { "오늘의 영화 순위 \($0)" }
    
//    private let layout = [
//        GridItem(.flexible(minimum: 120)),
//        GridItem(.flexible(minimum: 120)),
//        GridItem(.flexible(minimum: 120))
//    ]
    
//    private let layout = [
//        GridItem(.flexible(minimum: 100, maximum: 140)),
//        GridItem(.fixed(100)),
//        GridItem(.fixed(100))
//    ]
    
    private let layout = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: layout, content: {
                ForEach(dummy, id: \.self ) { item in
                    ZStack {
                        Color.random()
                        Text(item)
                    }
                }
            })
            .padding() // 바깥 여백
        }
        .onAppear { // 화면 띄어졌을 때
            dummy.insert("두다다", at: 0)
            // Cannot use mutating member on immutable value: 'self' is immutable -> @State로 처리
        }
        .task {
            
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(movie: .constant(
            [
                Movie(name: "aa"),
                Movie(name: "bb"),
                Movie(name: "cc"),
                Movie(name: "cac"),
                Movie(name: "c2c")
            ]
        ))
    }
}
