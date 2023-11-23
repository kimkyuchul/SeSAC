//
//  TabBadgeView.swift
//  SeSACVersionSwiftUI
//
//  Created by 김규철 on 2023/11/23.
//

import SwiftUI

struct TabBadgeView: View {
    var body: some View {
        TabView {
//            Text("1")
//                .tabItem { Image(systemName: "house") }
//                .badges(20)
//            ContentView()
//                .tabItem { Image(systemName: "star") }
//                .badges(10)
//            Text("3")
//                .tabItem { Image(systemName: "gear") }
//                .badges(50)
            
            ForEach(TabItem.allCases, id: \.hashValue) { item in
                item.rootView
                    .tabItem { item.image }
                

            }
        }
        // 페이지, 탭바 변경
        .tabViewStyle(.automatic)
    }
}

extension TabBadgeView {
    
    private enum TabItem: CaseIterable {
        case home
        case favorite
        case chat
        case setting
        
        var image: Image {
            switch self {
            case .home:
                return Image(systemName: "house")
            case .favorite:
                return Image(systemName: "star")
            case .chat:
                return Image(systemName: "house")
            case .setting:
                return Image(systemName: "gear")
            }
        }
        
        // 모든 뷰가 가지고 있는 타입이 다르기 때문에 -> 퉁치는 느낌에서 some을 쓴다.
        // @ViewBuilder 붙이지 않으면 타입 에러
        // https://stackoverflow.com/questions/64587360/swiftui-function-declares-an-opaque-return-type-but-the-return-statements-in-i
        @ViewBuilder
        var rootView: some View {
            switch self {
            case .home:
                ContentView()
            case .favorite:
                ZStack {
                    Color.green
                    Text("favorite")
                }
            case .chat:
                ZStack {
                    Color.orange
                    Text("chat")
                }
            case .setting:
                ZStack {
                    Color.blue
                    Text("setting")
                }
            }
        }
    }
}

struct TabBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        TabBadgeView()
    }
}

