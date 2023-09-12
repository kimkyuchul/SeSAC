//
//  ViewController.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var nicknameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nicknameTextField.placeholder = "닉네임을 입력해여"
        
        resultLabel.text = "nickname_placeholder".localized
        
        // 열거형 활용 해보자
        
        resultLabel.text = "age_result".localized(number: 20)
    }


}





