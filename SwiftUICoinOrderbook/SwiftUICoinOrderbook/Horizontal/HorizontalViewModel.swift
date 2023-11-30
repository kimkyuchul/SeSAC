//
//  HorizontalViewModel.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/27.
//

import SwiftUI

final class HorizontalViewModel: ObservableObject {
    
    // State => view로 범주
    // Published
    @Published var value = 0.0
    @Published var dummy: [HorizontalData] = []
    
    @Published var askOrderBook: [OrderBookItem] = []
    @Published var bidOrderBook: [OrderBookItem] = []
    
    @Published var orderBookModel: [OrderBookModel] = []
    
    let marketData: Market
    
    init(marketData: Market) {
        self.marketData = marketData
    }
    
    func largestAskSize() -> Double {
        return askOrderBook.sorted(by: { $0.size > $1.size }).first!.size
    }
    
    func largestBidSize() -> Double {
        return bidOrderBook.sorted(by: { $0.size > $1.size }).first!.size
    }
    
    func timer() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            self.value += 0.5
            self.fetchDummyData()
            //DummyData 달라지도록 구성
            
        }
    }
    
    func fetchDummyData() {
        
        dummy = [
            HorizontalData(data: "감자"),
            HorizontalData(data: "고구마"),
            HorizontalData(data: "밤"),
            HorizontalData(data: "잣"),
            HorizontalData(data: "반달곰"),
            HorizontalData(data: "에어팟"),
            HorizontalData(data: "방구"),
            HorizontalData(data: "김치")
        ]
    }
    
    func largest() -> Int {
        let data = dummy.sorted(by: { $0.point > $1.point })
        return data.first!.point
    }
    
    func fetchOrderBook() {
        
        let url = URL(string: "https://api.upbit.com/v1/orderbook?markets=krw-btc")!
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else {
                print("no data")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([OrderBookModel].self, from: data)
                
                DispatchQueue.main.async {
                    
                    let orderbookModel = decodedData
                    
                    let result = decodedData.first?.orderbook_units ?? [OrderBookUnit(ask_price: 0, bid_price: 0, ask_size: 0, bid_size: 0)]
                    
                    let ask = result.map { OrderBookItem(price: $0.ask_price, size: $0.ask_size) }
                        .sorted(by: { $0.price > $1.price })
                    
                    let bid = result.map { OrderBookItem(price: $0.bid_price, size: $0.bid_size) }
                        .sorted(by: { $0.price > $1.price })
                    
                    self?.orderBookModel = orderbookModel
                    self?.askOrderBook = ask
                    self?.bidOrderBook = bid
                }
                
            } catch {
                print(error)
            }
        }
        .resume()
    }
}
