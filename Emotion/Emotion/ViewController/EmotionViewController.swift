//
//  EmotionViewController.swift
//  Emotion
//
//  Created by 김규철 on 2023/07/25.
//

import UIKit

final class EmotionViewController: UIViewController {
    
    @IBOutlet var emotionButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "OH MY MOOD"
        setButtonTag()
        setButtonLayout()
    }
    
    private func setButtonLayout() {
        for (index, button) in emotionButtons.enumerated() {
            button.backgroundColor = EmotionType.allCases[index].backgroundColor
            button.setImage(EmotionType.allCases[index].image, for: .normal)
            button.setUImenu(index: index)
        }
    }
    
    private func setButtonTag() {
        for (index, button) in emotionButtons.enumerated() {
            button.tag = index
        }
    }
    
    @IBAction func emotionButtonTapped(_ sender: UIButton) {
        
        let selectedEmotion = EmotionType.allCases[sender.tag]
        let emotionIndex = selectedEmotion.resultLogic
        
        switch selectedEmotion {
        case .exciting:
            EmotionManager.excitingIndex = emotionIndex(EmotionManager.excitingIndex, 1)
        case .happy:
            EmotionManager.happyIndex = emotionIndex(EmotionManager.happyIndex, 1)
        case .soso:
            EmotionManager.sosoIndex = emotionIndex(EmotionManager.sosoIndex, 1)
        case .upset:
            EmotionManager.upsetIndex = emotionIndex(EmotionManager.upsetIndex, 1)
        case .sad:
            EmotionManager.sadIndex = emotionIndex(EmotionManager.sadIndex, 1)
        }
    }
}


