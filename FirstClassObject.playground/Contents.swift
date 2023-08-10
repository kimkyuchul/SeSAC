import UIKit

// 함수 이름이 모두 같아도 에러가 발생하지 않는 이유는 오버로딩 특성 때문

// 매개변수 x 반환값 x
//func welcome() { // () -> () 매개변수도 없고 반환값도 없음
//    print("안녕하세요. 반갑습니다.")
//}

//// 매개변수 o 반환값 x
//func welcome(name: String) { // (String) -> () 매개변수가 있음 반환값은 없음
//    print("안녕하세요. \(name)님 반갑습니다.")
//}

//// 매개변수 o 반환값 o
//func welcome(name: String) -> String { // (String) -> (String) 매개변수가 있음 반환값도 있음
//    return "안녕하세요. \(name)님 반갑습니다."
//}

//// 매개변수 x 반환값 o
func welcome() -> String { // () -> (String) 매개변수가 없음 반환값도 있음
    return "안녕하세요. 반갑습니다."
}

//welcome() // 함수를 실행한 것
//welcome // 함수 타입이 어떻게 생겼어? 확인하는 것, 실행 x 함수 자체만 불러본 것 ex) () -> ()

// 함수 타입을 매개변수에 넣을 수 있다. 함수 자체를 넣는 것
func introduce(message: (String) -> ()) {
    
}


// Function Type : 함수가 가지고 있는 타입. 함수 호출 연산자 없음
// 각각의 함수가 타입을 가지고 있다는 것.
/*
 변수/상수나 데이터 구조 내에 자료형을 저장할 수 있다.
 함수의 반환값으로 자료형을 사용할 수 있다.
 함수의 인자값으로 자료형을 전달할 수 있다.
 */


func checkBankInformation(bank: String) -> Bool {
    let bankArray = ["우리", "신한", "국민"]
    return bankArray.contains(bank) ? true : false
}

//변수나 상수에 함수를 실행서 반환된 반환값을 대입한 것 (1급 객체의 특성은 아님)
let result = checkBankInformation(bank: "농협")

//변수나 상수에 함수 그 '자체'를 대입할 수 있다. (1급 객체의 특성)
//함수만 대입한 것으로, 함수가 실행된 상태는 아님

// (String) -> Bool : Funtion Type (ex. Tuple)
let checkAccount = checkBankInformation


// 함수를 호출하면 실행할 수 있음
// 매개변수명은 생략이 된다.
checkAccount("신한")

// 해당 함수의 타입은 : (String) -> String
func hello(username: String) -> String {
    return "저는 \(username)이다."
}

func hello(nickname: String) -> String {
    return "저는 \(nickname)이다다다다다다닫다ㅏ람쥐."
}

// (String, Int) -> String
func hello(username: String, age: Int) -> String {
    return "저는 \(username)이고 \(age)이다."
}

// Ambiguous use of 'hello' -> 오버로딩 특성으로 인해 반환값과 파라미터가 다르면서 이름은 같은 함수들이 스위프트는 헷갈림
//let example = hello

// 오버로딩 특성으로 함수를 구분하기 힘들 떄. 타입 어노테이션을 통해서 함수를 구별
// 타입 어노테이션만으로 함수를 구별할 수 없는 상황도 있다. (타입은 같지만, 파라미터 이름이 다른 경우)
//let example: (String) -> String = hello

// 함수 표기법을 사용한다면 타입어노테이션을 생략하더라도 함수를 구별할 수 있다.
//let example: (String) -> String = hello(nickname:)
let example = hello(nickname:)



example("고래밥")


// 지금까지 한 특성 1. 함수를 상수나, 변수에 대입해서 쓸 수 있다.
// 변수나 상수에 함수 그 '자체'를 대입할 수 있다. (1급 객체의 특성)


// 2. 함수의 반환 타입으로 함수를 사용할 수 있다.

func currentAccount() -> String { // () -> String
    return "계좌 있다는 얼럿임"
}

func noCurrentAccount() -> String { // () -> String
    return "계좌 없으니 계좌 생성 화면으로"
}

//func checkBank(bank: String) -> Bool {
//    let bankArray = ["우리", "신한", "국민"]
//    return bankArray.contains(bank) ? true : false
//}

// 가장 왼쪽에 위치한 -> 를 기준으로, 오른쪽에 놓인 모든 타입은 반환값을 의미
func checkBank(bank: String) -> () -> String {
    let bankArray = ["우리", "신한", "국민"]
    return bankArray.contains(bank) ? currentAccount : noCurrentAccount
    // 함수를 호출하는 것은 아니고, 함수를 던져줌!
}

// kyuchul = func checkBank(bank: String) -> () -> String
let kyuchul = checkBank(bank:"신한") // 함수 자체만 대입한 것 실행 x

kyuchul()

checkBank(bank: "신한")()




// 4개의 함수의 타입은 모두 같음 -> (Int, Int) -> Int

func plus(a: Int, b: Int) -> Int {
    return a + b
}

func minus(a: Int, b: Int) -> Int {
    return a - b
}

func multiply(a: Int, b: Int) -> Int {
    return a * b
}

func divide(a: Int, b: Int) -> Int {
    return a / b
}

func calculate(operand: String) -> (Int, Int) -> Int {
    
    switch operand {
    case "+": return plus
    case "-": return minus
    case "*": return multiply
    case "/": return divide
    default: return plus
        
    }
}

calculate(operand: "+") // 함수가 실행되고 있는 상태가 아님
calculate(operand: "+")(3,4)

let resultCalculate = calculate(operand: "*")
resultCalculate(5,9)



// 3. 함수의 인자값으로 함수를 사용할 수 있다.

func addNumber() { // () -> () == () -> Void <- 빈 튜플과 Void는 같은 의미
    print("홀수")
}

func evenNumber() {
    print("짝수")
}

// 함수 타입이 같은 의도하지 않는 함수
func setLabel() {
    
}

// 반환값이 없는데 리턴을 한다?
// 매개변수에 들어온 함수를 실행하기 위해 Return
func resultNumber(number: Int, add: () -> Void, even: () -> Void) {
    return number.isMultiple(of: 2) ? even() : add() // even, add 매개변수를 실행해라
    // () <= 실행구문
}

resultNumber(number: 2, add: addNumber, even: evenNumber)

// 함수 타입이 같은 함수들이 상당히 많을 수도 있다.
// setLabel이 들어갈 수 도 있다. <- 의도하지 않는 함수가 들어감
// 필요 이상의 함수가 자꾸 생성될 수 있음
resultNumber(number: 2, add: setLabel, even: evenNumber)


resultNumber(number: 2, add: { // 이름 없는 함수 (익명 함수) => 클로저
    print("홀수")
}, even: {
    print("짝수")
})

// 이름 없는 함수로 기능 자체를 구현
resultNumber(number: 8) {
    <#code#>
} even: {
    <#code#>
}

