//
//  NicknameViewModel.swift
//  SeSACRxThreads
//
//  Created by 김규철 on 2023/11/02.
//

import Foundation

import RxRelay
import RxSwift

final class NicknameViewModel {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let nicknameText: Observable<String>
    }
    
    struct Output {
        let nextButtonEnable: BehaviorSubject<Bool>
    }
    
    private let nextButtonEnable = BehaviorSubject(value: false)
    
    func tramsfrom(input: Input) -> Output {
        input.nicknameText
            .withUnretained(self)
            .map { owner, text in
                owner.validate(text: text)
            }
            .bind(to: nextButtonEnable)
            .disposed(by: disposeBag)
            
        return Output(nextButtonEnable: nextButtonEnable)
    }
    
    private func validate(text: String) -> Bool {
        return text.count >= 2 && text.count < 6
    }
}
