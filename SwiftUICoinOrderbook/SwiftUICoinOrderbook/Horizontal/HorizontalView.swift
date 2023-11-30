//
//  HorizontalView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/27.
//

import SwiftUI
import WidgetKit

struct HorizontalView: View {
    
//    @StateObject var viewModel = HorizontalViewModel()
    
    @StateObject var viewModel = HorizontalViewModel(marketData: Market(market: "krw-btc", korean: "비트코인", english: "BitCoin"))
    
    var body: some View {
        ScrollView {
            GeometryReader { proxy in
                // 하위뷰에 대한 size 정보를 준다.
                // ex) GeometryReader의 하위뷰는 VStack
                let graphWidth = proxy.size.width * 0.7
                
                VStack {
                    ForEach(viewModel.askOrderBook, id: \.id) { item in
                        HStack {
                            Text(item.price.formatted())
                                .frame(width: proxy.size.width * 0.2)
                            ZStack(alignment: .leading) {
                                
                                let graphSize = item.size / viewModel.largestAskSize() * graphWidth
                            
                                Rectangle()
                                    .foregroundStyle(Color.blue.opacity(0.4))
                                    .frame(maxWidth: graphSize, alignment: .leading)
//                                    .frame(maxWidth: graphWidth, alignment: .leading)
                                Text(item.size.formatted())
                                    .frame(width: graphWidth)
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                        }
                        .frame(height: 40)
                    }
                }
                .background(Color.green)
                .onTapGesture {
                    viewModel.timer()
                    print(proxy)
                }
            }
            .onAppear {
                // 타이머를 언제 deinit 시켜주는게 좋은지 체크
                // view가 사라지는 시점에 timer를 deinit 시켜줘야하나?
                viewModel.timer()
                viewModel.fetchOrderBook()
                //UserDefaults AppGroup
                UserDefaults.groupShared.set(viewModel.marketData.korean, forKey: "Market")
                print(UserDefaults.groupShared.set(viewModel.marketData.korean, forKey: "Market"))
                
                WidgetCenter.shared.reloadTimelines(ofKind: "JavierOrderbook")
            }
        }
    }
}

struct HorizontalView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalView()
    }
}
