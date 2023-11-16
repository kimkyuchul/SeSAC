//
//  SearchView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/16.
//

import SwiftUI

struct SearchView: View {
    
    @State var randomNumber = 0
    
    init(randomNumber: Int = 0) {
        self.randomNumber = randomNumber
        print("SearchView")
    }
    
    var body: some View {
        VStack {
            HueView()
            jackView
            kokoView()
            Text("부랜 \(randomNumber)")
                .font(.largeTitle)
                .background(Color.random())
            Button("클릭") {
                randomNumber = Int.random(in: 1...100)
            }
        }
    }
    
    var jackView: some View {
        Text("jack")
            .font(.largeTitle)
            .background(Color.random())
    }
    
    func kokoView() -> some View {
        Text("코종")
            .font(.largeTitle)
            .background(Color.random())
    }
}

struct HueView: View {
    
    init() {
        print("HueView") // init은 @State 값이 변경될 때마다 계속 호출이 된다. SearchView에 하위뷰 인스턴스를 가지고 있기 때문이다.
    }
    
    var body: some View {
        Text("휴")
            .font(.largeTitle)
            .background(Color.random()) // body는 연산 프로퍼티이다. -> 메모리에 올라가지 않음
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

extension Color {
    static func random() -> Color {
        return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
}
