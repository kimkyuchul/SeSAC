import UIKit

var greeting = "Hello, playground"


struct User {
    let name = "고래밥" //인스턴스 프로퍼티
    static let originalName = "Kyu" // 타입 프로퍼티 -> 메타타입에서 나온 것
}

User.originalName
User.self.originalName // self는 생략되어 있는 것
// 메타 타입 그 자체는 User.Type, 메타 타입의 값은 User.self

// name에 접근하기 위해선 일반적으로 인스턴스를 만듬
let user = User()
user.name

// func type<T, Metatype>(of value: T) -> Metatype
// String은 인스턴스의(ex. 고래밥)의 타입
// "고래밥" => String
// Stirng => String.type
type(of: user.name) // String.Type

// 구조체나, 열거형, 클래스 등의 유형 그 자체를 표현
// 타입의 타입을 메타타입이라고 함
// User() -> User -> User.type
type(of: user)

// 타입 그자체에 접근했기 때문에 타입 프로퍼티에 접근이 가능하다.
type(of: user).originalName

// 타입의 값을 가지고 오고 싶을 때 self가 붙는다.
// 그렇지만 항상 생략되서 쓰는 것
let number: Int = 8.self

// 타입에 대한 확장
let result: Int.Type = Int.self // Int.self <- 자기 자신 그 자체를 부르는 것


//        AF.request(url, method: .get).validate()
//            .responseDecodable(of: Lotto.self) { response in
//                guard let value = response.value else { return }
//                print("responseDecodable:", value)
//            }

// Lotto.self <- Lotto 구조체의 인스턴스가 아닌 Lotto 구조체의 자체를 부름
// Lotto 구조체 형식에 값을 넣고 싶은 것

class a {
    let aa: Int = 2
}

a.self
