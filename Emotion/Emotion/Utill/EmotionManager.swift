//
//  EmotionManager.swift
//  Emotion
//
//  Created by 김규철 on 2023/07/25.
//

import Foundation

class EmotionManager {
    
    @UserDefault(key: "exciting", defaultValue: 0)
    static var excitingIndex: Int
    
    @UserDefault(key: "happy", defaultValue: 0)
    static var happyIndex: Int
    
    @UserDefault(key: "soso", defaultValue: 0)
    static var sosoIndex: Int
    
    @UserDefault(key: "upset", defaultValue: 0)
    static var upsetIndex: Int
    
    @UserDefault(key: "sad", defaultValue: 0)
    static var sadIndex: Int
}

extension EmotionManager {
    static func reset() {
        EmotionManager.excitingIndex = 0
        EmotionManager.happyIndex = 0
        EmotionManager.sosoIndex = 0
        EmotionManager.upsetIndex = 0
        EmotionManager.sadIndex = 0
    }
}

