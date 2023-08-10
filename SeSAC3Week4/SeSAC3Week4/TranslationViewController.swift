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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        translationTextview.resignFirstResponder()
        self.title = "번역"
        self.view.backgroundColor = .systemBackground
        originalTextview.font = .systemFont(ofSize: 30, weight: .regular)
        originalTextview.backgroundColor = .secondarySystemFill
        originalTextview.text = ""
        setLayout()
        requestButton.addTarget(
            self,
            action: #selector(requestButtonClicked),
            for: .touchUpInside)
    }
    
    
    private func setLayout() {
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
    
    @objc func requestButtonClicked(_ sender: UIButton) {
        translationTextview.resignFirstResponder()
        
        self.postDetectLanguage { result in
            switch result {
            case .success(let data):
                let url = "https://openapi.naver.com/v1/papago/n2mt"
                let hearder: HTTPHeaders = [
                    "X-Naver-Client-Id": APIKey.naverID,
                    "X-Naver-Client-Secret": APIKey.naverSecret
                ]
                let parameters: Parameters = [
                    "source": "\(data)",
                    "target": "es",
                    "text": self.originalTextview.text ?? ""
                ]
                
                AF.request(url, method: .post, parameters: parameters, headers: hearder).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        
                        let data = json["message"]["result"]["translatedText"].stringValue
                        
                        self.translationTextview.text = data
                    case .failure(let error):
                        print(error)
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension TranslationViewController {
    private func postDetectLanguage(completed: @escaping (Result<String, NetworkError>) -> Void)  {
        let url = "https://openapi.naver.com/v1/papago/detectLangs"
        let hearder: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverID,
            "X-Naver-Client-Secret": APIKey.naverSecret
        ]
        let parameters: Parameters = [
            "query": originalTextview.text ?? ""
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: hearder).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let data = json["langCode"].stringValue
                
                completed(.success(data))
                
                print(data)
                
                print(json)
            case .failure(let error):
                switch response.response?.statusCode {
                case 400:
                    completed(.failure(.Emptytext))
                case 500:
                    completed(.failure(.Emptytext))
                default:
                    completed(.failure(.unknownError(error)))
                }
            }
            
        }
    }
}

extension TranslationViewController {
    enum NetworkError: Error {
        case Emptytext
        case InternalServerErrors
        case unknownError(Error)
        
        var errorString: String {
            switch self {
            case .Emptytext:
                return "text가 없습니다"
            case .InternalServerErrors:
                return "Internal server errors"
            case .unknownError(_):
                return "unknownError"
            }
        }
    }
}
