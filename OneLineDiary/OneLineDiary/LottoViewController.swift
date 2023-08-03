//
//  LottoViewController.swift
//  OneLineDiary
//
//  Created by 김규철 on 2023/08/03.
//

import UIKit

class LottoViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    
    let pickerView = UIPickerView()
    
//    let list = ["김규철", "2024", "2025", "2026", "2027"]
    
//    var list = Array(1...1100)
    // No exact matches in call to subscript -> list의 타입 어노테이션 설정
    var list: [Int] = Array(1...1100).reversed()
//    var alist = Array(repeating: "A", count: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(list[row])"
    }
    
}
