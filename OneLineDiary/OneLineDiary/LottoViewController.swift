//
//  LottoViewController.swift
//  OneLineDiary
//
//  Created by 김규철 on 2023/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var bonusNumberLabel: UILabel!
    let pickerView = UIPickerView()
    
    let list = [1079, 1078, 1077, 1076, 1075]
    
    //    var list = Array(1...1100)
    // No exact matches in call to subscript -> list의 타입 어노테이션 설정
    //    var list: [Int] = Array(1...1100).reversed()
    //    var alist = Array(repeating: "A", count: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        getLottoAPI(number: 1079)
        
    }
    
    func getLottoAPI(number: Int) {
        let url = "https://dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get).validate(statusCode: 200...399).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let date = json["drwNoDate"].stringValue
                let bounsNumber = json["bnusNo"].intValue
                
                DispatchQueue.main.async {
                    self.datelabel.text = date
                    self.bonusNumberLabel.text = "\(bounsNumber)"
                }
                
                print(date, bounsNumber)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setLayout() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        textField.inputView = pickerView
        // 커서 색
        textField.tintColor = .clear
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(row)")
        
        textField.text = "\(list[row])"
        
        getLottoAPI(number: list[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(list[row])"
    }
    
}
