//
//  SignUpViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit

import RxSwift
import RxCocoa

import SwiftUI

class SignUpViewController: UIViewController {
    
    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let validationButton = UIButton()
    let nextButton = PointButton(title: "다음")
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.white
        
        configureLayout()
        configure()
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        disposeExample()
        incrementExample()
    }
    
    deinit {
        print(#function)
    }
    
    func incrementExample() {
        let increment = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        
        increment
            .subscribe(with: self) { owner, text in
                print("next - \(text)")
            } onError: { owner, error in
                print("error - \(error)")
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed") // 명시적으로 호출될 떄
            }
            .disposed(by: disposeBag)
    }
    
    func disposeExample() {
        let textArray = BehaviorSubject(value: ["bran", "jack", "hue", "koko"])
        //        Observable.from(["bran", "jack", "hue", "koko"])
        
        //        textArray
        //            .subscribe(with: self) { owner, text in
        //                print("next - \(text)") // 방출한다.
        //            } onError: { owner, error in // 노티피케이션.
        //                print("error - \(error)")
        //            } onCompleted: { owner in // 노티피케이션.
        //                print("onCompleted")
        //            } onDisposed: { owner in
        //                print("onDisposed")
        //            }
        //            .disposed(by: disposeBag)
        
//        textArray.onNext(["aa"])
//        textArray.onError(JackError.jack)
        
        let textArrayValue = textArray
            .subscribe(with: self) { owner, text in
                print("next - \(text)") // 방출한다.
            } onError: { owner, error in // 노티피케이션.
                print("error - \(error)")
            } onCompleted: { owner in // 노티피케이션.
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            textArrayValue.dispose()
        }
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(PasswordViewController(), animated: true)
    }
    
    func configure() {
        validationButton.setTitle("중복확인", for: .normal)
        validationButton.setTitleColor(Color.black, for: .normal)
        validationButton.layer.borderWidth = 1
        validationButton.layer.borderColor = Color.black.cgColor
        validationButton.layer.cornerRadius = 10
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(validationButton)
        view.addSubview(nextButton)
        
        validationButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(100)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(validationButton.snp.leading).offset(-8)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}


enum JackError: Error {
    case jack
}
