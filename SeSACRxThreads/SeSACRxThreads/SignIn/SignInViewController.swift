//
//  SignInViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit

import RxSwift
import RxCocoa

class SignInViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let signInButton = PointButton(title: "로그인")
    let signUpButton = UIButton()
    let test = UISwitch()
//    let isOn = Observable.of(false)
    let isOn = BehaviorSubject(value: true)
    let iisOn = PublishSubject<Bool>()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testSwitch()
        
        view.backgroundColor = Color.white
        
        configureLayout()
        configure()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
//        incrementExample()
//        aboutPublishSubject()
//        aboutBehaviorSubject()
//        aboutReplaySubject()
//        aboutAsyncSubject()
//        bind()
//        aboutCombineLatest()
        
        signInButton.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.navigationController?.pushViewController(SearchViewController(), animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func aboutCombineLatest() {
//        let a = BehaviorSubject(value: 3)
//        let b = BehaviorSubject(value: "가")
        
        let a = PublishSubject<Int>()
        let b = PublishSubject<String>()
        
        Observable.combineLatest(a, b) { first, second in //전달하는 옵저버블에 모든 값이 1회 이상 방출이 된 상태에서 최신값을 준다.
            return "결과: \(first) 그리고 \(second)"
        }
        .subscribe(with: self) { owner, data in
            print(data)
        }
        .disposed(by: disposeBag)
        
        
        a.onNext(2)
        a.onNext(1)
        a.onNext(5)
        
        b.onNext("나")
        b.onNext("다")
        b.onNext("라")
    }
    
    func bind() {
        let email = emailTextField.rx.text.orEmpty
        let password = passwordTextField.rx.text.orEmpty
        
        let validation = Observable.combineLatest(email, password) { email, password in
            return email.count > 8 && password.count >= 6
        }
        
        validation
            .bind(to: signInButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        
        validation
            .subscribe(with: self) { owner, value in
                owner.signInButton.backgroundColor = value ? UIColor.blue : UIColor.red
                owner.emailTextField.layer.borderColor = value ? UIColor.blue.cgColor : UIColor.red.cgColor
                owner.passwordTextField.layer.borderColor = value ? UIColor.blue.cgColor : UIColor.red.cgColor
            }
            .disposed(by: disposeBag)
        
        
        signInButton.rx.tap
            .subscribe(with: self) { owner, _ in
                print("signInButton")
            }
            .disposed(by: disposeBag)
    }
    
    func aboutAsyncSubject() {
        let async = AsyncSubject<Int>()
        
        async.onNext(20)
        async.onNext(30)
        async.onNext(4)
        async.onNext(2)
        async.onNext(1)
        
        async
            .subscribe(with: self) { owner, text in
                print("AsyncSubject - \(text)")
            } onError: { owner, error in
                print("AsyncSubject - \(error)")
            } onCompleted: { owner in
                print("AsyncSubject onCompleted")
            } onDisposed: { owner in
                print("AsyncSubject onDisposed")
            }
            .disposed(by: disposeBag)
        
        async.onNext(3)
        async.onNext(3)
        async.on(.next(9))
        
        async.onCompleted() // 9 만 방출 -> onCompleted를 만나야 일이 시작된다
        
        async.onNext(3)
    }
    
    func aboutReplaySubject() {
        let replay = ReplaySubject<Int>.create(bufferSize: 3)
        
        replay.onNext(20)
        replay.onNext(30)
        replay.onNext(4)
        replay.onNext(2)
        replay.onNext(1)
        
        replay
            .subscribe(with: self) { owner, text in
                print("ReplaySubject - \(text)")
            } onError: { owner, error in
                print("ReplaySubject - \(error)")
            } onCompleted: { owner in
                print("ReplaySubject onCompleted")
            } onDisposed: { owner in
                print("ReplaySubject onDisposed")
            }
            .disposed(by: disposeBag)
        
        replay.onNext(3)
        replay.onNext(3)
        replay.on(.next(9))
        
        replay.onCompleted()
        
        replay.onNext(3)
    }
    
    func aboutBehaviorSubject() {
        let behavior = BehaviorSubject<Int>(value: 200)
        
        behavior.onNext(20)
        behavior.onNext(30)
        
        behavior
            .subscribe(with: self) { owner, text in
                print("BehaviorSubject - \(text)")
            } onError: { owner, error in
                print("BehaviorSubject - \(error)")
            } onCompleted: { owner in
                print("BehaviorSubject onCompleted")
            } onDisposed: { owner in
                print("BehaviorSubject onDisposed")
            }
            .disposed(by: disposeBag)
        
        behavior.onNext(3)
        behavior.onNext(3)
        behavior.on(.next(9))
        
        behavior.onCompleted()
        
        behavior.onNext(3)
    }
    
    func aboutPublishSubject() {
        let publish = PublishSubject<Int>()
        
        publish.onNext(20)
        publish.onNext(30)
        
        publish
            .subscribe(with: self) { owner, text in
                print("PublishSubject - \(text)")
            } onError: { owner, error in
                print("PublishSubject - \(error)")
            } onCompleted: { owner in
                print("PublishSubject onCompleted")
            } onDisposed: { owner in
                print("PublishSubject onDisposed")
            }
            .disposed(by: disposeBag)
        
        publish.onNext(3)
        publish.onNext(3)
        publish.on(.next(9))
        
        publish.onCompleted()
        
        publish.onNext(3)
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
            
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.disposeBag = DisposeBag()
        }
    }
    
    func testSwitch() {
        view.addSubview(test)
        test.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.leading.equalTo(100)
        }
        
        isOn
            .subscribe(onNext: { [weak self] bool in
                self?.test.setOn(bool, animated: false)
            })
            .disposed(by: disposeBag)
        
        isOn
            .bind(to: test.rx.isOn)
            .disposed(by: disposeBag)
        
        isOn.onNext(true) // 구독 이후에 방출 가능
        
//        test.setOn(true, animated: false)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isOn.onNext(false)
        }
    }
    
    @objc func signUpButtonClicked() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    
    func configure() {
        signUpButton.setTitle("회원이 아니십니까?", for: .normal)
        signUpButton.setTitleColor(Color.black, for: .normal)
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(signInButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}
