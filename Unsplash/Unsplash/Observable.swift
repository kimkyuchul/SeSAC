//
//  Observable.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/12.
//

import Foundation

class Observable<T> {
    
//    // 기능을 실행. -> 옵저버
//    private var listener: (String) -> Void = { nickname in
//        print(nickname) // 얼럿 레이블,, 화면전환 등을 실행
//    }
    
    private var listener: ((T) -> Void)?
    
    // 데이터가 바뀔 떄 마다 didSet으로 감지 한다.
    var value: T {
        didSet {
            // 데이터가 바뀐 벨류를 전달한다.
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        print(#function)
        // 클로저를 실행하는데 value를 같이 보내준다.
        // 첫번째로 실행되는 건 bind 구문이다.
        closure(value)
        // 즉슨, 뷰컨에서 값이 바뀔 때 리스너에 들어가고 있는 것이다. 값이 바뀔 떄마다 실행되는 이유는 이친구 때문이다.
        // 값이 변경될 때마다 실행되는 이유는 didset이 실행되고 -> didset안에 listener가 실행되고 listener에는 closure가 담긴 상태이기 때문이다.
        listener = closure
    }
}
