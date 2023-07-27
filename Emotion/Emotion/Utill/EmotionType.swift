//
//  EmotionType.swift
//  Emotion
//
//  Created by 김규철 on 2023/07/25.
//

import UIKit

enum EmotionType: CaseIterable, CustomStringConvertible {
    typealias Operation = (Int, Int) -> (Int)
    case exciting
    case happy
    case soso
    case upset
    case sad
    
    // 튜플로 한번에 묶기
    // 튜플에 이름 선언해서
    var image: UIImage {
        switch self {
        case .exciting:
            return UIImage(named: "emoji1")!
        case .happy:
            return UIImage(named: "emoji2")!
        case .soso:
            return UIImage(named: "emoji3")!
        case .upset:
            return UIImage(named: "emoji4")!
        case .sad:
            return UIImage(named: "emoji5")!
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .exciting:
            return .systemRed
        case .happy:
            return .systemOrange
        case .soso:
            return .systemYellow
        case .upset:
            return .systemMint
        case .sad:
            return .systemBlue
        }
    }
    
    var description: String {
        switch self {
        case .exciting:
            return "완전행복지수"
        case .happy:
            return "적당미소지수"
        case .soso:
            return "그냥저냥지수"
        case .upset:
            return "좀속상한지수"
        case .sad:
            return "많이슬픈지수"
        }
    }
    
    var userDefault: Int {
        switch self {
        case .exciting:
            return EmotionManager.excitingIndex
        case .happy:
            return EmotionManager.happyIndex
        case .soso:
            return EmotionManager.sosoIndex
        case .upset:
            return EmotionManager.upsetIndex
        case .sad:
            return EmotionManager.sadIndex
        }
    }
}

extension EmotionType {
    var resultLogic: Operation {
        switch self {
        case .exciting, .happy, .soso, .upset, .sad:
            return { a, b in a + b }
        }
    }
}
