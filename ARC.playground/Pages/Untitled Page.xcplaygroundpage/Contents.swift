import UIKit

// Any: 모든 타입에 대해 대응 가능 (구조체, 열거형, 클래스, 클로저 등)
// AnyObject: 모든 클래스 타입의 인스턴스만 담을 수 있다. 즉, 상속이 가능한 인스턴스만 가능하다. => 클래스 제약 설정이 가능하다.
// AnyObject는 typealias로 구성되어 있다.
// Any vs AnyObject

// typealias Void = ()
func welcome() -> Void {
    
}

//typealias man = false

let name = "고래밥"
let age = 0
//let gender = false
let birth = Date()

//let arrayList: [Any] = [name, age, gender, birth]

// any로 작성 시 런타임 시점에서 타입이 결정되기 때문에, 런타임 오류가 발생할 수 있어 사용에 주의가 필요하다. => 타입 캐스팅
//arrayList[1] + 1 // Cannot convert value of type 'Any' to expected argument type 'Int'
//arrayList[1] as! Int + 1

// Cannot convert value of type 'Bool' to expected element type 'AnyObject'
// Cannot convert value of type 'Date' to expected element type 'AnyObject'
// Cannot convert value of type 'Int' to expected element type 'AnyObject'
// Cannot convert value of type 'String' to expected element type 'AnyObject'
//let anyObjectArrayList: [AnyObject] = [name, age, gender, birth]

// typealias AnyObject
protocol Sample: AnyObject { //class 
    func example()
}

class UserClass: Sample {
    func example() {
        
    }
    
    
}

// Non-class type 'UserStruct' cannot conform to class protocol 'Sample'
//struct UserStruct: Sample {
//    func example() {
//        <#code#>
//    }
// }



