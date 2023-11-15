//
//  HomeView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/15.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        ScrollView(.vertical) {
            VStack(spacing: 70) {
                ForEach(0..<4) { item in
                    HomeCategoryView()
                }
            }
        }
    }
}

struct HomeCategoryView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(0..<5) { item in
                    AsyncImageView()
                        .frame(width: 100, height: 100)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
