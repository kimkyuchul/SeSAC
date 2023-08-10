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
    @IBOutlet var translationTextview: UITextView!
    @IBOutlet var requestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalTextview.text = ""
        translationTextview.text = ""
        translationTextview.isEditable = false
        
        
    }
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let hearder: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverID,
            "X-Naver-Client-Secret": APIKey.naverSecret
        ]
        let parameters: Parameters = [
            "source": "ko",
            "target": "en",
            "text": originalTextview.text ?? ""
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: hearder).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let data = json["message"]["result"]["translatedText"].stringValue
                
                print(json)
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
}
