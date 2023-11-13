//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by 김규철 on 2023/11/02.
//

import Foundation

import RxRelay
import RxSwift

final class BirthdayViewModel {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let birthDayDate: Observable<Date>
    }
    
    struct Output {
        let nextButtonEnable: BehaviorSubject<Bool>
        let year: BehaviorSubject<String>
        let month: BehaviorSubject<String>
        let day: BehaviorSubject<String>
    }
    
    private let year = BehaviorSubject<String>(value: "")
    private let month = BehaviorSubject<String>(value: "")
    private let day = BehaviorSubject<String>(value: "")
    
    func tramsfrom(input: Input) -> Output {
        
        let zip = Observable.zip(year, month, day)
        
        input.birthDayDate
            .compactMap { date in
                let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
                return component
            }
            .
            .disposed(by: disposeBag)
//            .bind(to: nextButtonEnable)
//            .disposed(by: disposeBag)
            
        return Output(nextButtonEnable: nextButtonEnable)
    }
    
    private func validate(text: String) -> Bool {
        return text.count >= 2 && text.count < 6
    }
    
    private func date(date: DateComponents) -> (String, String, String)
    return 
}

