//
//  CalculateViewModel.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/13.
//

import Foundation

class CalculateViewModel {
    
    var firstNumber: SequenceObservavle<String?> = SequenceObservavle("10")
    
    var secondNumber: SequenceObservavle<String?> = SequenceObservavle("20")
    
    var resultText = SequenceObservavle("결과는 30")
    
    var tempText = SequenceObservavle("테스트를 위한 텍스트이다.")
    
    func format(for number: Int) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        return numberFormat.string(for: number)!
    }
    
    func presentNumberFormat() {
        guard let first = firstNumber.value, let firstConvertNumber = Int(first) else {
            tempText.value = "숫자로 변환할 수 없는 문자"
            return
        }
        
        
        tempText.value = format(for: firstConvertNumber)
    }
    
}

extension CalculateViewModel {
    func calculate() {
        guard let first = firstNumber.value, let firstConvertNumber = Int(first) else {
            resultText.value = "첫번째 값에서 오류가 발생"
            return
        }
        
        guard let second = secondNumber.value, let secondConvertNumber = Int(second) else {
            resultText.value = "두번쨰 값에서 오류가 발생"
            return
        }
        
        resultText.value = "결과는 \(firstConvertNumber + secondConvertNumber)"
    }
}



@propertyWrapper
final class aaObservable<Value> {
    var wrappedValue: Value
    
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}
