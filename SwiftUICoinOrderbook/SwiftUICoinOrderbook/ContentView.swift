//
//  ContentView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/20.
//

import SwiftUI

struct ContentView: View {
    
    // ObservableObject의 Published가 신호가 보내면 ObservedObject가 받는다.
    @ObservedObject var viewModel = ContentViewModel()
    
    @State var renderingTestNumber = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("테스트: \(renderingTestNumber)")
                NavigationLink("배너 테스트", value: renderingTestNumber)
                VStack {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(1..<5) { data in
                                bannerView()
                                    .frame(width: 400)
                                    .onTapGesture {
                                        viewModel.fetchBanner()
                                    }
                                //                        .containerRelativeFrame(.horizontal)
                            }
                        }
                        // 스크롤 하고자 하는 대상에 대한 레이아웃 설정
//                        .scrollTargetLayout()
                    }
//                    .scrollTargetBehavior(.viewAligned)
//                    .safeAreaPadding([.horizontal], 40)
                    .scrollIndicators(.visible)
                    ListView()
                }
            }
            .scrollIndicators(.hidden)
            .refreshable {
                // Pull to refresh
                viewModel.fetchBanner()
                renderingTestNumber = Int.random(in: 1...100)
//                money = dummy.shuffle()
            }
//            .onAppear {
//                viewModel.fetchAllMarket()
//            }
            .navigationTitle("My Wallet")
            .navigationDestination(for: Int.self) { _ in
                BannerTestView(testNumber: $renderingTestNumber)
            }

        }
    }
    
    func bannerView() -> some View {
        ZStack {
            Rectangle()
                .fill(viewModel.banner.color)
                .overlay {
                    Circle()
                        .fill(.white.opacity(0.3))
                        .offset(x: -90, y: -0)
                        .scaleEffect(1.3, anchor: .center)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .frame(maxWidth: .infinity)
                .frame(height: 200)
            VStack(alignment: .leading) {
                Spacer()
                Text("나의 소비내역")
                    .font(.title3)
                    .bold()
                Text(viewModel.banner.totalFormat)
                    .font(.title)
                    .bold()
            }
            // ios 17 ++
//            .visualEffect { content, geometryProxy in
////                content.offset(x: geometryProxy.size.width / 2, y: geometryProxy.size.height / 2)
//                content.offset(x: scrollOffset(geometryProxy))
//            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
    
    
//    func scrollOffset(_ proxy: GeometryProxy) -> CGFloat {
//        let result = proxy.bounds(of: .scrollView)?.minX ?? 0
//        return result
//    }
    
//    func listView(data: Market) -> some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text(data.korean)
//                Text(data.english)
//            }
//            Spacer()
//            Text(data.market)
//        }
//        .padding(.horizontal, 20)
//        .padding(.vertical, 8)
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
