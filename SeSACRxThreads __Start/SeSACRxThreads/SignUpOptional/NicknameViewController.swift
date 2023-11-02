//
//  NicknameViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NicknameViewController: UIViewController {
    
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let text = PublishSubject<String>()
    let disposeBag = DisposeBag()
    private let viewModel: NicknameViewModel
    
    init(viewModel: NicknameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.white
        configureLayout()
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        bind()
    }
    
    func bind() {
        let input = NicknameViewModel.Input(nicknameText: nicknameTextField.rx.text.orEmpty.distinctUntilChanged())
        let output = viewModel.tramsfrom(input: input)
        
        let nextButtonEnable = output.nextButtonEnable
            .asDriver(onErrorJustReturn: false)
        
        nextButtonEnable
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        nextButtonEnable
            .drive(nextButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        nextButtonEnable
            .drive(nicknameTextField.rx.borderColor)
            .disposed(by: disposeBag)
    }
        
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(BirthdayViewController(), animated: true)
    }
    
    
    func configureLayout() {
        view.addSubview(nicknameTextField)
        view.addSubview(nextButton)
        
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}

extension Reactive where Base: UITextField {
    var borderColor: Binder<Bool> {
        return Binder(self.base) { owner, bool in
            owner.layer.borderColor = bool ? UIColor.black.cgColor : UIColor.red.cgColor
        }
    }
}

extension Reactive where Base: UIButton {
    var backgroundColor: Binder<Bool> {
        return Binder(self.base) { owner, bool in
            owner.backgroundColor = bool ? UIColor.black : UIColor.red
        }
    }
}
