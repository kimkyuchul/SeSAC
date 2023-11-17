//
//  TransitionView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/15.
//

import SwiftUI

/*
 버튼을 클릭해서 화면 dismiss/App
 화면 전환시 데이터 전달
 */

struct TransitionView: View {
    
    @State private var isFull = false
    @State private var isSheet = false
    
    init(isFull: Bool = false, isSheet: Bool = false) {
        self.isFull = isFull
        self.isSheet = isSheet
        print("TransitionView init")
    }
    
    var body: some View {
        NavigationView {
            HStack(spacing: 20) {
                Button("Full") {
                    isFull.toggle()
                }
                Button("sheet") {
                    isSheet.toggle()
                    
                }
                NavigationLink("Push") { // Link 존재 시 RenderView init이 TransitionView가 init 될 때 같이 호출이 된다.
                    NavigationLazyView(CategoryView())
                }
                NavigationLink("Push") {
                    NavigationLazyView(RenderView())
                }
            }
            .sheet(isPresented: $isSheet, content: {
                RenderView()
            })
            .fullScreenCover(isPresented: $isFull) {
                RenderView()
            }
        }
    }
}

struct TransitionView_Previews: PreviewProvider {
    static var previews: some View {
        TransitionView()
    }
}
