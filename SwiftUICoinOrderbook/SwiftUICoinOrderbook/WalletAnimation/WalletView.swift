//
//  WalletView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/22.
//

import SwiftUI

struct WalletView: View {
    
    @State private var isExpandable = false
    @State private var isShowDetail = false
    private let wallet = walletList
    @State private var currentWallet = WalletModel(name: "", index: 0)  // 탭한 카드가 무엇인 지 알기 위함
    
    @Namespace var animation
    
    var body: some View {
        VStack {
            topTitle()
            cardSpace()
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
        .overlay {
            if isShowDetail {
                WalletDetailView(
                    showDetail: $isShowDetail,
                    currentWallet: currentWallet,
                    animation: animation
                )
            }
        }
    }
    
    func cardSpace() -> some View {
        ScrollView {
            ForEach(wallet, id: \.self) { item in
                cardView(item)
            }
        }
        .overlay {
            // 애니메이션이 먼저 실행될 뷰
            Rectangle()
                .fill(.black.opacity(isExpandable ? 0 : 0.01))
                .onTapGesture {
                    withAnimation {
                        isExpandable = true
                    }
                }
        }
    }
    
    func cardView(_ data: WalletModel) -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(data.color)
            .frame(height: 150)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .offset(y: CGFloat(data.index) * (isExpandable ? 0 : -130) )
            .onTapGesture {
                withAnimation {
                    currentWallet = data
                    isShowDetail = true
                    //                    // 단계적으로 실행되지 않는다.
                    //                    // 애니메이션이 먼저 실행될 뷰가 깔려있어야 한다. 애니메이션이 실행된 이후 cardView를 눌렀을 때 다음뷰로만 넘어가게 만들어야 한다.
                    //                    if isExpandable == true {
                    //                        isShowDetail = true
                    //                    }
                }
            }
        // 화면 전환 애니메이션을 위한 그룹화, id 매칭
            .matchedGeometryEffect(id: data, in: animation)
    }
    
    func topTitle() -> some View {
        Text("Javier Wallet")
            .font(.largeTitle)
            .bold()
        // State Bool 값에 따라 alignment 변경
            .frame(maxWidth: .infinity, alignment: isExpandable ? .center : .leading)
        // 백그라운드 지정 전에 frame 설정
            .background(.yellow)
            .overlay(alignment: .trailing) {
                topOverlayButton()
            }
            .padding()
    }
    
    func topOverlayButton() -> some View {
        Button {
            withAnimation {
                isExpandable = false
            }
        } label: {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .padding()
                .background(.black, in: Circle())
        }
        .rotationEffect(.degrees(isExpandable ? 225 : 45))
        .opacity(isExpandable ? 1 : 0)
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
