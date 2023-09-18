//
//  NumberViewController.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/18.
//

import UIKit

class NumberViewController: UIViewController {
    
    @IBOutlet var numberTexrField: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    let viewModel = NumberViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTexrField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
        
        viewModel.number.bind { jack in
            self.numberTexrField.text = jack
        }
        
        viewModel.result.bind { value in
            self.resultLabel.text = value
        }
    }
    
    @objc func numberTextFieldChanged() {
        viewModel.number.value = numberTexrField.text
        viewModel.convertNumber()
    }
}




