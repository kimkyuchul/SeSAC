//
//  MenuView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/13.
//

import SwiftUI


// Spacer()
struct MenuView: View {
    
    // MenuView에서만 쓰일 뷰라면 MenuView struct 안에 Propery로 선언해서 사용해도 된다.
    var cardPropery: some View {
        VStack(spacing: 10) {
            Image(systemName: "star")
                .background(.red)
            Text("토스뱅크")
                .background(.blue)
        }
        .padding()
        .background(.yellow)
    }
    
    var body: some View {
      
        VStack {
            HStack(spacing: 20) {
                cardPropery
                CardView(image: "person", text: "또스증권")
                CardView(image: "heart", text: "또스이체")
            }
            List {
                Section("안녕") {
                    Text("보안과 인증")
                        .modifier(PointBorderText())
                    DatePicker(selection: .constant(Date())) {
                        Text("Date")
                    }
                    Text("보안과 인증")
                    ColorPicker("컬러 설정", selection: .constant(.yellow))
                    Text("보안과 인증")
                }
                Section("자산") {
                    Text("보안과 인증")
                    Text("보안과 인증")
                    Text("보안과 인증")
                }
            }
            .listStyle(.plain)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct CardView: View {
    let image: String
    let text: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: image)
                .background(.red)
            Text(text)
                .background(.blue)
                .underline()
        }
        .padding()
        .background(.yellow)
    }
}

// custom modifier
struct PointBorderText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding(10)
            .foregroundColor(.white)
            .background(.purple)
    }
}

//extension View {
//    
//    func asPointBorderText() -> some View {
//        return PointBorderText()
//    }
//}
