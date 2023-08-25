//
//  GenericViewController.swift
//  SeSAC3Week6
//
//  Created by 김규철 on 2023/08/24.
//

import UIKit

import SnapKit

class GenericViewController: UIViewController {
    
    let sampleLabel = UILabel()
    let sampleButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        
        let value = sumInt(a: 3, b: 8)
        print(value)
        
        let generic = sum(a: 9, b: 8)
        print(generic)
        
        view.addSubview(sampleLabel)
        sampleLabel.backgroundColor = .yellow
        sampleLabel.text = "제네릭 테슷흐"
        configureBorder(view: sampleLabel)
        sampleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(50)
        }
        
        view.addSubview(sampleButton)
        sampleButton.backgroundColor = .yellow
        sampleButton.setTitle("제네릭 테슷흐", for: .normal)
        configureBorder(view: sampleButton)
        sampleButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(100)
            make.top.equalTo(sampleLabel.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
    
    }
    
}
