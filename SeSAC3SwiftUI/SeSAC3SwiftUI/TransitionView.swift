//
//  TransitionView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/15.
//

import SwiftUI

/*
 버튼을 클릭해서 화면 DISMiss/App
 화면 전환시 데이터 전달
 */

struct TransitionView: View {
    
    @State private var isFull = false
    @State private var isSheet = false
    
    var body: some View {
        NavigationView {
            HStack(spacing: 20) {
                Button("Full") {
                    isFull.toggle()
                }
                Button("sheet") {
                    isSheet.toggle()
                    
                }
                NavigationLink("Push") {
                    RenderView()
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
