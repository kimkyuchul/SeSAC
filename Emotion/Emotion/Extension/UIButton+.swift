//
//  UIButton+.swift
//  Emotion
//
//  Created by 김규철 on 2023/07/25.
//

import UIKit

extension UIButton {
    func setUImenu(index: Int) {
        let fivePointincrease = UIAction(title: "5점 추가", image: UIImage(systemName: "star"), handler: self.increase(index: index, countIndex: 5))
        
        let tenPointincrease = UIAction(title: "10점 추가", image: UIImage(systemName: "star"), handler: self.increase(index: index, countIndex: 10))
        
        let reset = UIAction(title: "리셋", image: UIImage(systemName: "star"), handler: { _ in EmotionManager.reset() })
        
        self.menu = UIMenu(title: "타이틀",
                           image: UIImage(systemName: "heart"),
                           identifier: nil,
                           options: .displayInline,
                           children: [fivePointincrease, tenPointincrease, reset])
        
    }
    
    private func increase(index: Int, countIndex: Int) -> UIActionHandler {
        let actionHandler: UIActionHandler = { _ in
            let selectedEmotion = EmotionType.allCases[index]
            let emotionIndex = selectedEmotion.resultLogic
            
            switch selectedEmotion {
            case .exciting:
                EmotionManager.excitingIndex = emotionIndex(EmotionManager.excitingIndex, countIndex)
            case .happy:
                EmotionManager.happyIndex = emotionIndex(EmotionManager.happyIndex, countIndex)
            case .soso:
                EmotionManager.sosoIndex = emotionIndex(EmotionManager.happyIndex, countIndex)
            case .upset:
                EmotionManager.upsetIndex = emotionIndex(EmotionManager.happyIndex, countIndex)
            case .sad:
                EmotionManager.sadIndex = emotionIndex(EmotionManager.happyIndex, countIndex)
            }
        }
        return actionHandler
    }
}

