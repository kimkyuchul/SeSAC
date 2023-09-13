//
//  LottoViewModel.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/13.
//

import Foundation

enum ErrorType {
    case networkError
    case drwoError
}

protocol Input: AnyObject {
    func viewDidLoadEvent()
    func lottobuttonTapp()
}

protocol Output: AnyObject {
    var number1: Observable<Int> { get }
    var number2: Observable<Int> { get }
    var number3: Observable<Int> { get }
    var number4: Observable<Int> { get }
    var number5: Observable<Int> { get }
    var number6: Observable<Int> { get }
    var lottoMoney: Observable<String> { get }
    var errorObservable: Observable<ErrorType>? { get }
}


class LottoViewModel: Input, Output  {
    var number1: Observable<Int> = Observable(0)
    var number2: Observable<Int> = Observable(0)
    var number3: Observable<Int> = Observable(0)
    var number4: Observable<Int> = Observable(0)
    var number5: Observable<Int> = Observable(0)
    var number6: Observable<Int> = Observable(0)
    var lottoMoney: Observable<String> = Observable("")
    var errorObservable: Observable<ErrorType>?
    
    private var drwo = 1
    
    func viewDidLoadEvent() {
        fetchLotto(drwo: 1022) 
    }
    
    func lottobuttonTapp() {
        if drwo < 1000 {
            fetchLotto(drwo: drwo)
        } else {
            errorObservable?.value = .drwoError
        }
        
        self.drwo = drwo + 1
    }
}

extension LottoViewModel {
    func fetchLotto(drwo: Int) {
        LottoService.shared.lottoService(number: drwo) { [weak self] result in
            switch result {
            case .success(let value):
                guard let lotto = value else { return }
                    self?.number1.value = lotto.drawNo1
                    self?.number2.value = lotto.drawNo2
                    self?.number3.value = lotto.drawNo3
                    self?.number4.value = lotto.drawNo4
                    self?.number5.value = lotto.drawNo5
                    self?.number6.value = lotto.drawNo6
                    self?.lottoMoney.value = lotto.totSellAmount.format
            case .failure(_):
                self?.errorObservable?.value = .networkError
            }
        }
    }
}
    
