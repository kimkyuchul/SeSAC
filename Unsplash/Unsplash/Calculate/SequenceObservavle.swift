//
//  SequenceObservavle.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/13.
//

import Foundation

class SequenceObservavle<T> {
    
    // 네임이 바뀔 때도 똑같이 introduce를 실행시키고 싶다.
    // luckyNumber를 업데이트 시키는것처럼 () -> Void를 자체를 업데이트하여 SequenceObservavle를 사용하는 모든 곳에서 사용가능 하도록
    // 클래스 내에서만 사용하기 때문에 private 설정을 한다.
   private var listener: ((T) -> Void)?
    
    var value: T {
        // 이름 초기화 이후에 이름이 변경되었을 때를 감지
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
        // number라는 매개변수를 줄임
        // 뷰컨에서 호출 시 이스케이핑을 통해 뷰를 바안딩하는 클로저를 만듬
    func bind(_ sample: @escaping (T) -> Void) {
        // 첫 실행에 sample을 실행시키고 싶다면 쓰는 구문이다. 첫실행 이후에 값이 변경될 떄마다 sample이 호출되고 싶다면 해당 구문을 제거해도 된다.
        // name을 쓰지 안으면 호출되지 않는다.
        sample(value)
        // Assigning non-escaping parameter 'sample' to an @escaping closur
        // sample을 외부에서 사용할 수 있도록 하기 위해 escaping
        // listener에 sample을 담았기 때문에 이 함수 외부에서 사용
        listener = sample // 이 기능을 listener에 대입해줬기 때문에 sample이 호출된 이후 값이 바뀔 때마다 sample이 실행되는 것이다.
        // listener = sample 없다면 최초 호출하고 그 이후로 값이 변경될 때마다 뷰가 변경되지 않을 것이다.
    }
}
