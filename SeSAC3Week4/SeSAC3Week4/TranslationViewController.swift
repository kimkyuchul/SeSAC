//
//  TranslationViewController.swift
//  SeSAC3Week4
//
//  Created by 김규철 on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

final class TranslationViewController: UIViewController {
    
    @IBOutlet var originalTextview: UITextView!
    private let requestButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPink
        button.setTitleColor(.white, for: .normal)
        button.setTitle("번역해", for: .normal)
        button.layer.cornerRadius = 22
        return button
    }()
    private let translationTextview: UITextView = {
        let textView = UITextView()
        textView.text = ""
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .secondarySystemFill
        textView.font = .systemFont(ofSize: 30, weight: .regular)
        textView.textColor = .black
        return textView
    }()
    
    var networkService: PaPagoNetwork
    
    required init?(coder: NSCoder) {
        self.networkService = NetworkService()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "번역"
        self.view.backgroundColor = .systemBackground
        setAddTarget()
        setLayout()
        
        UserDefaults.standard.set("고래밥", forKey: "nickname")
        
        UserDefaultsHelper.shard.nickname
        
    }
    
    @objc func requestButtonClicked(_ sender: UIButton) {
        translationTextview.resignFirstResponder()
        
        let text = self.originalTextview.text
        
        networkService.postDetectLanguage(query: text ?? "") { result in
            switch result {
            case .success(let code):
                self.networkService.postTranslateLanguage(langCode: code, text: text ?? "") { result in
                    switch result {
                    case .success(let data):
                        self.translationTextview.text = data
                    case .failure(let error):
                        print(error.errorString)
                    }
                }
            case .failure(let error):
                print(error.errorString)
            }
        }
    }
    
    private func setLayout() {
        originalTextview.font = .systemFont(ofSize: 30, weight: .regular)
        originalTextview.backgroundColor = .secondarySystemFill
        originalTextview.text = ""
        
        view.addSubview(translationTextview)
        view.addSubview(requestButton)
        
        NSLayoutConstraint.activate([
            translationTextview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            translationTextview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            translationTextview.topAnchor.constraint(equalTo: originalTextview.bottomAnchor, constant: 20),
            translationTextview.bottomAnchor.constraint(equalTo: requestButton.topAnchor, constant: -10)
            //            translationTextview.heightAnchor.constraint(equalTo: originalTextview.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            requestButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            requestButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            requestButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),
            requestButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func setAddTarget() {
        setLayout()
        requestButton.addTarget(
            self,
            action: #selector(requestButtonClicked),
            for: .touchUpInside)
    }
}
