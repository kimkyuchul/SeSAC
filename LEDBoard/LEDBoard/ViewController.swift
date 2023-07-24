//
//  ViewController.swift
//  LEDBoard
//
//  Created by 김규철 on 2023/07/24.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var textFieldBackView: UIView! {
        didSet {
            textFieldBackView.layer.cornerRadius = textFieldBackView.frame.height/2
        }
    }
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var ledResultLabel: UILabel!
    @IBOutlet weak var textColorChangeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
        setupDelegation()
        setGestureRecognizer()
        setTextFieldLayout(textField: textField)
        setButtonLayout(label: ledResultLabel)
        setButtonLayout()
    }
    
    private func setupDelegation() {
        textField.delegate = self
    }
    
    private func setGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func getColor() -> UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
    
    // MARK: -  @objc Methods
    @objc private func viewTapped(_ gesture: UITapGestureRecognizer) {
        textFieldBackView.isHidden = textFieldBackView.isHidden == false ? true : false
    }
 
    // MARK: - Action Methods
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        
        guard let text = textField.text, !text.isEmpty else { return }
        
        ledResultLabel.text = textField.text
        textField.text = nil
    }
    
    @IBAction func textColorChangeButtonTapped(_ sender: UIButton) {
        ledResultLabel.textColor = getColor()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        guard let text = textField.text, !text.isEmpty else { return false }
        
        ledResultLabel.text = textField.text
        textField.text = nil
        return true
    }
}

// MARK: - Layout
extension ViewController {
    private func setTextFieldLayout(textField: UITextField) {
        textField.backgroundColor = .white
        textField.placeholder = "단어를 쳐봐요."
        textField.textColor = .black
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.magenta.cgColor
    }
    
    private func setButtonLayout() {
        [sendButton, textColorChangeButton].forEach { button in
            button.backgroundColor = UIColor.orange
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.magenta.cgColor
        }
    }
    
    private func setButtonLayout(label: UILabel) {
        label.text = "LED 입니다.."
        label.font = .systemFont(ofSize: 60)
        label.sizeToFit()
    }
}

