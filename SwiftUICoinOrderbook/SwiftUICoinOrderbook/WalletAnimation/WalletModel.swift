//
//  WalletModel.swift
//  SwiftUICoinOrderbook
//
//  Created by 김규철 on 2023/11/22.
//

import SwiftUI

struct WalletModel: Hashable {
    let color = Color.random()
    let name: String
    let index: Int
}

var walletList = [
    WalletModel(name: "Hue Card", index: 0),
    WalletModel(name: "jack Card", index: 1),
    WalletModel(name: "ko Card", index: 2),
    WalletModel(name: "bran Card", index: 3),
    WalletModel(name: "javi Card", index: 4)
]
