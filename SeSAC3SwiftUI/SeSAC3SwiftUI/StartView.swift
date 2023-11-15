//
//  StartView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/15.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Text("홈 화면")
                    Image(systemName: "house.fill")
                }
            CategoryView()
                .tabItem {
                    Text("검색 화면")
                    Image(systemName: "pencil")
                }
            RenderView()
                .tabItem {
                    Text("설정 화면")
                    Image(systemName: "star")
                }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
