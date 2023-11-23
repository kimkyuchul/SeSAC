//
//  ContentView.swift
//  SeSACVersionSwiftUI
//
//  Created by 김규철 on 2023/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
//            .Modifier 하나하나의 분기처리는 되지 않는다. 뷰 단위로 분기처리가 가능
//            if #available(iOS 15.0, *) {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundStyle(.blue)
//            } else {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundColor(.accentColor)
//            }
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foreground(.orange)
            
//            Text("Hello, world!")
//                .modifier(PointBackgroundText())
            Text("Hello, world!")
                .asPointBackgroundText()
            Text("Hello!")
                .asPointBackgroundText()
            
            Button {
                
            } label: {
                Text("Button")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.black)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
