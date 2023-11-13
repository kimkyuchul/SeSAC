//
//  ContentView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/13.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        //        Button("클릭하기") {
        //            let value = type(of: self.body)
        //            print(value)
        //        }
        //        .foregroundColor(Color.black)
        //        .background(Color.brown)
        
        VStack {
            Text("안녕하세요.")
                .padding()
                .bold()
                .background(Color.red)
                .foregroundStyle(Color.green)
                .font(.largeTitle)
                .padding()
                .background(Color.blue)
                .border(.orange, width: 12)
            
            Text("안녕하세요.")
                .padding()
                .bold()
                .background(Color.red)
                .foregroundStyle(Color.green)
                .font(.largeTitle)
                .padding()
                .background(Color.blue)
                .border(.orange, width: 12)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
