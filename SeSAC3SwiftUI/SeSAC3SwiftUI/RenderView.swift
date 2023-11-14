//
//  RenderView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/13.
//

import SwiftUI

struct RenderView: View {
    
    @State var age = 10
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("push") {
                    MenuView()
                }
                
                Text("Hue: \(age) \(Int.random(in: 1...100))")
                Text("Jack: \(Int.random(in: 1...100))")
                bran
                kokoView()
                Button("클릭") {
                    age = Int.random(in: 1...100)
                }
            }
            .navigationTitle("네비게이션 타이틀") // 콘텐츠 밖 영역에 설정
            .navigationBarItems(leading: Text("클릭"))
        }
    }
    
    var bran: some View {
        Text("Bran: \(Int.random(in: 1...100))")
    }
}

struct RenderView_Previews: PreviewProvider {
    static var previews: some View {
        RenderView()
    }
}

struct kokoView: View {
    var body: some View {
        Text("koko: \(Int.random(in: 1...100))")
    }
}
