//
//  StatsViewController.swift
//  Emotion
//
//  Created by 김규철 on 2023/07/25.
//

import UIKit

final class StatsViewController: UIViewController {
    
    @IBOutlet var statsViews: [UIView]!
    @IBOutlet var emotionCountLabels: [UILabel]!
    @IBOutlet var emotionDescriptionLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "OH MY MOOD"
        setStatusViewLayout()
        setEmotionDescriptionLabelLayout()
        setEmotionCountLabelLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setEmotionCountLabelValue()
    }
    
    private func setStatusViewLayout() {
        for (index, view) in statsViews.enumerated() {
            view.backgroundColor = EmotionType.allCases[index].backgroundColor
            view.layer.borderColor = EmotionType.allCases[.random(in: 0...index)].backgroundColor.cgColor
            view.layer.borderWidth = 2
            view.layer.cornerRadius = 20
            view.clipsToBounds = true
        }
    }
    
    private func setEmotionDescriptionLabelLayout() {
        for (index, label) in emotionDescriptionLabels.enumerated() {
            label.text = EmotionType.allCases[index].description
            label.textColor = .black
            label.font = .boldSystemFont(ofSize: 16)
            label.sizeToFit()
        }
    }
    
    private func setEmotionCountLabelLayout() {
        for label in emotionCountLabels {
            label.textColor = .black
            label.font = .boldSystemFont(ofSize: 20)
            label.sizeToFit()
        }
    }
    
    private func setEmotionCountLabelValue() {
        for (index, label) in emotionCountLabels.enumerated() {
            label.text = "\(EmotionType.allCases[index].userDefault)" + "점"
        }
    }
    
    @IBAction func showBottomSheet(_ sender: UIButton) {
        if #available(iOS 15.0, *) {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let VC = storyBoard.instantiateViewController(withIdentifier: "BottomSheetViewController") as? BottomSheetViewController else { return }
            
            if let presentationController = VC.presentationController as? UISheetPresentationController {
                presentationController.detents = [.medium(), .large()]
            }
            self.present(VC, animated: true)
        }
    }
}
