//
//  ButtonView.swift
//  SeSACVersionSwiftUI
//
//  Created by 김규철 on 2023/11/23.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        VStack {
            text
                .wrapToButton { print("aa") }
            image
                .wrapToButton { print("bb") }
            rectangle
                .wrapToButton { print("cc") }
            
            
//            // 버튼에 모든 요소를 래핑해서 사용
//            Button {
//
//            } label: {
//                text
//            }
//
//            Button {
//
//            } label: {
//                image
//            }
//            .buttonStyle(.plain)
//
//            Button {
//
//            } label: {
//                rectangle
//            }
//            .buttonStyle(.borderedProminent)

//            text
//                .onTapGesture {
//                    print("text click")
//                }
//            image
//                .onTapGesture {
//                    print("image click")
//                }
//            rectangle
//                .onTapGesture {
//                    print("rectangle click")
//                }
        }
    }
    
    var text: some View {
        Text("Hello, World!")
            .padding(30)
            .background(.black)
            .foreground(.white)
            .font(.largeTitle)
    }
    
    var image: some View {
        Image(systemName: "person.fill")
            .scaleEffect(2)
            .padding()
    }
    
    var rectangle: some View {
        Rectangle()
            .padding()
            .frame(height: 100)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
