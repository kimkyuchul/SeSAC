//
//  SignTextField.swift
//  SeSAC3Week6
//
//  Created by 김규철 on 2023/08/24.
//

import UIKit

class SignTextField: UITextField {
    
    // CodeBase
    // Interface를 사용하지 않고, UIview를 상속 받은 Custom Class를 코드로 구성할 때 사용되는 초기화 구문이다.
    // UIView
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    // XIB -> NIB 변환 과젱서 객체 생성 시 필요한 init 구문 (StoryBoard)
    // Interfaace Builder에서 생성된 뷰들이 초기화될 때 실행되는 구문
    // NSCoding
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
    }
    
    private func setLayout() {
        borderStyle = .none
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        textAlignment = .center
        font = .boldSystemFont(ofSize: 15)
        layer.cornerRadius = 8
    }
}

protocol Mobile {
    init(name: String)
}

class Apple: Mobile {
    // required: 프로토콜에서 생성된 경우 사용하는 키워드
    // Required Initializer
    required init(name: String) {
        
    }
}
