//: [Previous](@previous)

import UIKit

func makeIncrement(value: Int) -> () -> Int {
    var total = 0
    
    func increment() -> Int { //외부 함수의 생명 주기는 끝났지만, 내부 함수(result)는 아직 살아 있는 상태이다.
        total += value // total, value 라는 값을 내부적으로 저장하고 있ㄷ. (캡쳐)
        return total // 클로저는 값을 캡쳐할 떄, 값 타입인지 참조 타입인지 상관 없이 Reference Capture를 한다.
    }
    
    return increment
}

let result = makeIncrement(value: 10)

result()
result()
result()
result()


func sampleClosure() {
    var number = 0
    print("1 - \(number)")
    
    let closure: () -> Void = { [number] in // 값 타입으로 캡쳐 -> 처음에 number의 값은 0이기 때문에 
        print("closure - \(number)")
    }
    
    closure()
    
    number = 100
    
    closure()
    
    print("2 - \(number)")
}

sampleClosure()
