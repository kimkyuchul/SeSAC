//
//  WalletView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/22.
//

import SwiftUI

struct WalletView: View {
    
    @State private var isExpandable = false
    
    var body: some View {
        VStack {
            topTitle()
            Spacer()
            Button("AnimationOn") {
                withAnimation(.linear.delay(0.1)) {
                    isExpandable = true
                }
            }
            Button("AnimationOFF") {
                withAnimation {
                    isExpandable = false
                }
            }
        }
    }
    
    
    func topTitle() -> some View {
        Text("Javier Wallet")
            .font(.largeTitle)
            .bold()
            .padding()
        // State Bool 값에 따라 alignment 변경
            .frame(maxWidth: .infinity, alignment: isExpandable ? .leading : .center)
        // 백그라운드 지정 전에 frame 설정
            .background(.yellow)
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
