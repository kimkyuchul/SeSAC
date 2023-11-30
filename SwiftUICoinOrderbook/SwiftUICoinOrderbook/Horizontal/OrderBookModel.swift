//
//  OrderBookModel.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/28.
//

import Foundation

struct OrderBookModel: Decodable {
    let market: String
    let timestamp: Int
    let total_ask_size, total_bid_size: Double
    let orderbook_units: [OrderBookUnit]
}

struct OrderBookUnit: Decodable {
    let ask_price, bid_price: Double
    let ask_size, bid_size: Double
}

struct OrderBookItem: Hashable, Identifiable {
    let id = UUID()
    let price: Double
    let size: Double
}
