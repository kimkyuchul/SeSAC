//
//  TextViewController.swift
//  SeSAC3Week6
//
//  Created by 김규철 on 2023/08/22.
//

import UIKit

import SnapKit

class TextViewController: UIViewController {
    
    // 방법 1
    // static func setImageView() -> UIImageView
//    var photoImageView: UIImageView = setImageView()
    
    // 방법 2
    // func setImageView() -> UIImageView
    // setImageView()가 실행되고 초기화 될 수 있도록 lazy var 설정
//    lazy var photoImageView: UIImageView = setImageView()
    
   private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemCyan
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let titleTextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "제목 입력해"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    private let weatherTextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "날짜 입력해"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    private let textView = {
        let view = UITextView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.textAlignment = .left
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        // 기존의 배열을 다른 타입으로 변경해주겠다.
        [photoImageView, titleTextField, weatherTextField, textView].forEach { v in
            view.addSubview(v)
        }
        
        setConstraints()
    }
    
    private func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        weatherTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leading.equalTo(titleTextField.snp.leading)
            make.trailing.equalTo(titleTextField.snp.trailing)
            make.height.equalTo(titleTextField.snp.height)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(weatherTextField.snp.bottom).offset(20)
            make.leading.equalTo(titleTextField.snp.leading)
            make.trailing.equalTo(titleTextField.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    
    }
    
    
     func setImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemCyan
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
}
