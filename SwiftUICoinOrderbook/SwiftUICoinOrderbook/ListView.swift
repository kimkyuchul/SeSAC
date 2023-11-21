//
//  ListView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/21.
//

import SwiftUI

struct ListView: View {
    
    // @ObservedObject -> 데이터 초기화
    // @StateObject -> 데이터 유지
    @StateObject var viewModel = ListViewModel()
    
    var body: some View {
        LazyVStack {
            Button("서버 통신") {
                viewModel.fetchAllMarket()
            }
            ForEach(viewModel.market, id: \.self) { item in // \.self 이기 때문에 Hashable하여 같은 데이터 시 한개 밖에 안나온다.
                HStack {
                    VStack(alignment: .center) {
                        Text(item.korean)
                            .fontWeight(.bold)
                        Text(item.english)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text(item.market)
                }
                .padding()
            }
        }
        .onAppear {
            print("testonAppear") // onAppear마다 네트워크 통신이 게속된다.
//            viewModel.fetchAllMarket()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
