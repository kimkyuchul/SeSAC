//
//  ContentView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var banner = Banner()
    @State var dummy = [
        Money(amount: 21700, product: "컴포즈커피", category: .food),
        Money(amount: 500000, product: "청년절망적금", category: .deposit),
        Money(amount: 9000, product: "선식당", category: .food),
        Money(amount: 27000, product: "클린코드", category: .study),
        Money(amount: 150000, product: "스키장", category: .hobby),
        Money(amount: 600000, product: "월세", category: .house),
        Money(amount: 68400, product: "통신비", category: .house),
        Money(amount: 7000, product: "교동짬뽕", category: .food),
        Money(amount: 6500, product: "커피빈", category: .food),
        Money(amount: 4700, product: "쉬즈베이글토스트문래점", category: .food),
        Money(amount: 8800, product: "무인아이스크림할인매장", category: .food),
        Money(amount: 100000, product: "주택청약", category: .house),
        Money(amount: 13900, product: "스플렌더", category: .hobby),
        Money(amount: 1500, product: "컴포즈커피", category: .food),
        Money(amount: 7800, product: "컴포즈커피", category: .food),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    bannerView()
                    LazyVStack {
                        ForEach(dummy, id: \.self) { data in
                            listView(data: data)
                        }
                    }
                }
            }
            .refreshable {
                // Pull to refresh
                banner = Banner()
                dummy.shuffle()
            }
            .navigationTitle("My Wallet")
        }
    }
    
    func bannerView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.green)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
            VStack(alignment: .leading) {
                Spacer()
                Text("나의 소비내역")
                Text(banner.totalFormat)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
    
    func listView(data: Money) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(data.category.rawValue)")
                Text("\(data.product)")
            }
            Spacer()
            Text("\(data.amountFormat)\nKRW-BTC")
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
