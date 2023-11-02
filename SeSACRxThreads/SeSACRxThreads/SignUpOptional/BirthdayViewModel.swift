//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by 김규철 on 2023/11/02.
//

import Foundation

import RxSwift
import RxRelay

final class BirthdayViewModel {
    
    let disposeBag = DisposeBag()
    
    let birtday: BehaviorSubject<Date> = BehaviorSubject(value: .now)
    
    let year = BehaviorSubject(value: 0)
    let month = BehaviorSubject(value: 0)
    let day = BehaviorSubject(value: 0)
    
    init() {
        
        birtday
            .subscribe(with: self) { owner, birth in
                let component = Calendar.current.dateComponents([.year, .month, .day], from: birth)
                owner.year.onNext(component.year!)
                owner.month.onNext(component.month!)
                owner.day.onNext(component.day!)
            }
            .disposed(by: disposeBag)
    }
}
