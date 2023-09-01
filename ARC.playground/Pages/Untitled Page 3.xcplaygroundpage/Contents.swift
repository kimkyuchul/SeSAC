//: [Previous](@previous)

import Foundation

class User {
    let nickname = "kyu"
    
    lazy var introduce: () -> String = { [weak self] in
        // Cannot find 'self' in scope; did you mean to use it in a type or extension context? -> 동시에 인스턴스가 생성되면 안되기 때문에 초기화 순서를 lazy로 미룬다.
        return "안녕하세요, \(self?.nickname) \(Int.random(in: 1...100))" // 값을 캡쳐한 것 class가 Deinit 되더라도 self에 class가 캡쳐되어있는 상태이기 때문에 사용이 계속 가능
        // 생명주기가 끝나더라도 사용이 가능하도록 -> 클로저의 캡처리스트
        // closeure -> context, capturelist, scope, capture
    }
    
    init() {
        print("User Init")
    }
    
    deinit {
        print("User Deinit")
    }
}

// nickname이 올라가 있는 상태
var user: User? = User() // init이 된다. RC + 1
user?.nickname

let result = user?.introduce
print(result!())

user = nil //  RC - 1 // nickname 못 쓰는 상태
 
print(result!()) // 안녕하세요, nil로 나오는 이유 -> [weak self]를 선언했기 때문에 31번 라인 떄문에 마지막에 nil로 바뀜

//함수, 변수의 생명주기(스코프)

