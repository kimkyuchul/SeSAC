//
//  MainView.swift
//  SeSACVersionSwiftUI
//
//  Created by 김규철 on 2023/11/23.
//

import SwiftUI

struct MainView: View {
    
    @State
    var sampleTest = false
    
    var body: some View {
        //        if #available(iOS 16.0, *) {
        //            NavigationStack {
        //                Text("hello, world")
        //            }
        //        } else {
        //            NavigationView {
        //                Text("hello, world")
        //            }
        //        }
        //    }
        
        NavigationWrapper {
            // 텍스트 안에 다른 조건문으로 핸들링하는 순간 문제가 발생한다.
            // @ViewBuilder 문제
            Text("이것이 네비게이션 레퍼다")
            sample
                .navigationTitle("메인")
                .navigationBar {
                    Image(systemName: "star.fill")
                } trailing: {
                    Text("안녕")
                }

//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Image(systemName: "star")
//                    }
//                }
//                .navigationBarItems(
//                    leading: Image(systemName: "star"),
//                    trailing: EmptyView()
//                )
            
            // Type '()' cannot conform to 'View'
//            if sampleTest {
//                Text("ㅎㅇ")
//            } else {
//                Text("1")
//            }
        }
    }
    
    @ViewBuilder
    var sample: some View {
        if sampleTest {
            Text("ㅎㅇ")
        } else {
            Text("1")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
