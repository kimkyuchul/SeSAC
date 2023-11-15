//
//  PosterView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/15.
//

import SwiftUI

struct PosterView: View {
    
    @State private var isPresented = false
    
    var body: some View {
        ScrollView(showsIndicators: true) {
            LazyVStack {
                ForEach(0..<50) { item in
                    AsyncImageView()
                        .frame(width: 100, height: 100)
                        .onTapGesture {
                            isPresented.toggle()
                        }
                }
            }
            //            .frame(maxWidth: .infinity) // ScrollView의 width를 꽉차게
        }
        .background(.gray)
        .sheet(isPresented: $isPresented) {
            CategoryView()
        }
    }
}

struct PosterView_Previews: PreviewProvider {
    static var previews: some View {
        PosterView()
    }
}

