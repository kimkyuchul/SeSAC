//
//  ViewController.swift
//  CoinedWord
//
//  Created by 김규철 on 2023/07/21.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var hashTagButtons: [UIButton]!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var wordResultLabel: UILabel!
    @IBOutlet weak var coinedWordTextView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var customTextFiledView: UIView!
        
    var viewModel: WordViewModel!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel = WordViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setViewLayout()
        setLabelLayout()
        setTextFieldLayout()
        setButtonLayout()
        setHashTagButtons()
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
        
    // MARK: - HashTagButton의 title를 랜덤하게 바꾸는 함수
    private func setHashTagButtonInfo() {
        for button in hashTagButtons {
            button.setTitle(viewModel.getRandomWord(), for: .normal)
        }
    }
    
    // MARK: - Result 레이블에 값을 보여줄 함수
    private func showResult() {
        guard wordTextField.hasText,
              let text = wordTextField.text else { return self.alert(title: "오류", message: "문자를 입력해주세요.") }
                
        wordResultLabel.text = viewModel.getWordData()[text] ?? "검색 결과가 없수다."
        setHashTagButtonInfo()
    }
    
    // MARK: - Action Methods
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        showResult()
        view.endEditing(true)
    }
    
    @IBAction func wordTextFieldDidTapped(_ sender: UITextField) {
        showResult()
    }
    
    @IBAction func hashTagButtonTapped(_ sender: UIButton) {
        if let text = sender.titleLabel?.text {
            wordResultLabel.text = viewModel.getWordData()[text]
        }
    }
}

// MARK: - Layout
extension ViewController {
    private func setLabelLayout() {
        wordResultLabel.textColor = .orange
        wordResultLabel.numberOfLines = 0
        wordResultLabel.text = "적으라게"
    }

    private func setViewLayout() {
        customTextFiledView.layer.cornerRadius = 5
        customTextFiledView.layer.borderWidth = 3
        customTextFiledView.layer.borderColor = UIColor.orange.cgColor
        customTextFiledView.clipsToBounds = true
        
        coinedWordTextView.layer.borderWidth = 2
        coinedWordTextView.layer.borderColor = UIColor.orange.cgColor
        coinedWordTextView.backgroundColor = .white
    }
    
    private func setTextFieldLayout() {
        wordTextField.backgroundColor = .white
        wordTextField.placeholder = "제주도 방언을 검색해보세요."
        wordTextField.textColor = UIColor.orange
    }
    
    private func setButtonLayout() {
        searchButton.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        searchButton.tintColor = UIColor.white
        searchButton.backgroundColor = UIColor.orange
        searchButton.imageView?.contentMode = .scaleToFill
    }
    
    private func setHashTagButtons() {
        for button in hashTagButtons {
            button.setTitleColor(UIColor.orange, for: .normal)
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.orange.cgColor
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
            button.titleLabel?.numberOfLines = 2
        }
        setHashTagButtonInfo()
    }
}
