//
//  MovieView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/14.
//

import SwiftUI

struct MovieView: View {
    
    @State private var isPresented = false
    
    var body: some View {
        ZStack {
            Color.green
            Image("dummy")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            Image("dummy")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .border(Color.white, width: 10)
            Text("Hello, World!")
            VStack {
                Button("Show") {
                   isPresented = true
                }
                .padding()
                .background(.white)
                Spacer()
                HStack {
                    Circle()
                    Circle()
                    Circle()
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            TamagochiVIew()
        }
//        .fullScreenCover(isPresented: $isPresented) {
//            TamagochiVIew()
//        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}
