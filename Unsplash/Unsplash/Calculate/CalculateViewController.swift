//
//  CalculateViewController.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/13.
//

import UIKit

final class CalculateViewController: UIViewController {

    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var firstTextField:
    UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    let viewModel = CalculateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.firstNumber.bind { [weak self] number in
            self?.firstTextField.text = number
        }
        
        viewModel.secondNumber.bind { [weak self] number in
            self?.secondTextField.text = number
        }
        
        
        viewModel.resultText.bind { [weak self] number in
            self?.resultLabel.text = number
        }
        
        viewModel.tempText.bind { text in
            self.tempLabel.text = text
        }
        
        firstTextField.addTarget(self, action: #selector(firstTextFieldChanged), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(secondTextFieldChanged), for: .editingChanged)
    }
    
    @objc func firstTextFieldChanged() {
        viewModel.firstNumber.value = firstTextField.text
        viewModel.calculate()
        viewModel.presentNumberFormat()
    }
    
    @objc func secondTextFieldChanged() {
        viewModel.secondNumber.value = secondTextField.text
        viewModel.calculate()
    }
}


/*
 let sequence = SequenceObservavle("김")
 
 sequence.name = "aa"
 sequence.name = "bb"
 
 // 1번만 실행
 sequence.introduce { name in
     self.resultLabel.text = name
     self.view.backgroundColor = [UIColor.orange, UIColor.lightGray, UIColor.magenta].randomElement()!
 }
 
//        sequence.introduce(Int.random(in: 1...10)) {
//            self.view.backgroundColor = [UIColor.orange, UIColor.lightGray, UIColor.magenta].randomElement()!
//        }
 
 DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
     sequence.name = "잠" // 이름이 바뀔 때 리스너의 내용이 변경되는 것
 }
 
 // 프로그레스바 사용 시 쓰자 -> 네트워크 통신이 너무 빠를 시 0.5초정도는 설정해서 인디케이터 보여주도록
 DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
     sequence.name = "방구"
 }
 */
