//
//  Lotto.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/13.
//

import Foundation

struct Lotto: Codable {
    let totSellAmount: Int
    let returnValue: String
    let drawNoDate: String
    let firstWinAmount: Int
    let drawNo6: Int
    let drawNo4: Int
    let firstPrizeWinnerCount: Int
    let drawNo5: Int
    let bonusNo: Int
    let firstAccumulatedAmount: Int
    let drawNo: Int
    let drawNo2: Int
    let drawNo3: Int
    let drawNo1: Int
    
    enum CodingKeys: String, CodingKey {
        case totSellAmount = "totSellamnt"
        case returnValue
        case drawNoDate = "drwNoDate"
        case firstWinAmount = "firstWinamnt"
        case drawNo6 = "drwtNo6"
        case drawNo4 = "drwtNo4"
        case firstPrizeWinnerCount = "firstPrzwnerCo"
        case drawNo5 = "drwtNo5"
        case bonusNo = "bnusNo"
        case firstAccumulatedAmount = "firstAccumamnt"
        case drawNo = "drwNo"
        case drawNo2 = "drwtNo2"
        case drawNo3 = "drwtNo3"
        case drawNo1 = "drwtNo1"
    }
}


