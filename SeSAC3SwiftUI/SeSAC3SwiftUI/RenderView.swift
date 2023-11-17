//
//  RenderView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/13.
//

import SwiftUI

struct RenderView: View {
    // 시스템에서 정의된 값을 감지하고 뷰를 업데이트 할 수 있다.
//    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State var age = 10
    
    init(age: Int = 10) {
        self.age = age
        print("RenderView init")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.red, Color.gray, Color.blue]),
                                startPoint: .bottomLeading,
                                endPoint: .trailing)
                        )
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            RadialGradient(
                                gradient: Gradient(
                                    colors:
                                        [
                                            .red,
                                            .orange
                                        ]
                                ),
                                center: .topLeading,
                                startRadius: 10,
                                endRadius: 70
                            )
                        )
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            AngularGradient(
                                colors: [
                                    .yellow,
                                    .green
                                ],
                                center: .leading,
                                angle: .degrees(200)
                            )
                        )
                }
                .frame(width: .infinity, height: 100) // 쓸수 있는 width 다 써라 -> infinity
                
                NavigationLink("push") {
                    MenuView()
                }
                
                Text("Hue: \(age) \(Int.random(in: 1...100))")
                Text("Jack: \(Int.random(in: 1...100))")
                bran
                kokoView()
                Button(colorScheme == .dark ? "다크모드 클릭": "라이트 모드 클릭") {
                    age = Int.random(in: 1...100)
                    
                    dismiss.callAsFunction()
                    
//                    presentationMode.wrappedValue.dismiss()
                    
                    
                }
                .background(colorScheme == .dark ? .teal : .cyan)
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
