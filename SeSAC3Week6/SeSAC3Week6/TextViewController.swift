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
        imageView.contentMode = .scaleToFill
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
    
    private let photoPicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        // 기존의 배열을 다른 타입으로 변경해주겠다.
        [photoImageView, titleTextField, weatherTextField, textView].forEach { v in
            view.addSubview(v)
        }
        
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 사용할 수 있는지 체크
//        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
//            print("갤러리 사용 불가, 사용자에게 토스트/얼럿")
//            return
//        }
//
//        // sourceType을 photoLibrary로
//        photoPicker.sourceType = .photoLibrary
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("카메라 사용 불가, 사용자에게 토스트/얼럿")
            return
        }

        // sourceType을 photoLibrary로
        photoPicker.delegate = self
        photoPicker.sourceType = .camera
        photoPicker.allowsEditing = true
        
//        let fontPicker = UIFontPickerViewController()
//        let colorPicker = UIColorPickerViewController()
        
        present(photoPicker, animated: true)
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

extension TextViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 취소 버튼 클릭 시
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
        print(#function)
    }
    
    // 사진을 선택하거나 카메라 촬용 직후 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // originalImage: 원본이미지, editedImage: allowsEditing한 이미지
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.photoImageView.image = image
            dismiss(animated: true)
        }
    }
}
