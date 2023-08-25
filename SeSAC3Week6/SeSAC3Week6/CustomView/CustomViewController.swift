//
//  CustomViewController.swift
//  SeSAC3Week6
//
//  Created by 김규철 on 2023/08/24.
//

import UIKit

import SnapKit

class CustomViewController: UIViewController {
    
    private let idTextField = SignTextField(placeholder: "아이디 입력")
    
    private let passwordTextField = SignTextField(placeholder: "비번 입력")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .brown
        
        setHierachy()
        setConstraints()
    }
    
    private func setHierachy() {
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
    }
    
    private func setConstraints() {
        idTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(20)
            make.centerX.equalTo(idTextField.snp.centerX)
            make.size.equalTo(idTextField.snp.size)
        }
    }
}
