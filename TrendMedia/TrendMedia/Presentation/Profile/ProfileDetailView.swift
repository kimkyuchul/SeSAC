//
//  ProfileDetailView.swift
//  TrendMedia
//
//  Created by 김규철 on 2023/08/29.
//

import UIKit

final class ProfileDetailView: BaseView {

    private let textField: UITextField = {
        let v = UITextField()
        v.textColor = .black
        v.font = .boldSystemFont(ofSize: 14)
        v.clipsToBounds = true
        v.layer.borderWidth = 0.8
        v.layer.borderColor = UIColor.black.cgColor
        return v
    }()
    
    override func setHierarchy() {
        addSubview(textField)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(90)
        }
    }
    
    override func setLayout() {
        super.setLayout()
    }
}

extension ProfileDetailView {
    func getTextFieldText() -> String? {
       return textField.text
    }
}
