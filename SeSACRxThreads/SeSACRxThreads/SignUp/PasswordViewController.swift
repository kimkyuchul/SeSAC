//
//  PasswordViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PasswordViewController: UIViewController {
   
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
         
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        aboutUnicast()
        aboutMulticast()
    }
    
    func requestExample() {
        let request = APIManager.fetchData().share()
        
        request
            .subscribe(with: self) { owner, response in
                print(response)
            }
            .disposed(by: disposebag)
        
        request
            .subscribe(with: self) { owner, response in
                print(response)
            }
            .disposed(by: disposebag)
        
        request
            .map { data in
                "\(data.results.count)"
            }
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposebag)
    }
    
    func aboutUnicast() { //Observable
        let random = Observable.create { emmiter in
            emmiter.onNext(Int.random(in: 1...100))
            return Disposables.create()
        }
        
//        Observable.just(["1", "2", "3"])
        
        random
            .subscribe(with: self) { owner, value in
                print(value)
            }
            .disposed(by: disposebag)
        
        random
            .subscribe(with: self) { owner, value in
                print(value)
            }
            .disposed(by: disposebag)
        
        random
            .subscribe(with: self) { owner, value in
                print(value)
            }
            .disposed(by: disposebag)
        
        // random이 각각 3번 호출된다.
    }
    
    func aboutMulticast() { //subject
        
        let random = BehaviorSubject(value: 100)
        
        random.onNext(Int.random(in: 1...100))
        
        random
            .subscribe(with: self) { owner, value in
                print("Multicast", value)
            }
            .disposed(by: disposebag)
        
        random
            .subscribe(with: self) { owner, value in
                print("Multicast", value)
            }
            .disposed(by: disposebag)
        
        random
            .subscribe(with: self) { owner, value in
                print("Multicast", value)
            }
            .disposed(by: disposebag)
        
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(PhoneViewController(), animated: true)
    }
    
    func configureLayout() {
        view.addSubview(passwordTextField)
        view.addSubview(nextButton)
         
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
