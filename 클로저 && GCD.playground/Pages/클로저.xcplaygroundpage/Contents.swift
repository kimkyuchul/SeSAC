import UIKit

var greeting = "Hello, playground"

// () -> (), () -> Void
// 매개변수도 없고 반환값도 없는
func studyiOS() {
    print("gd")
}


let study: () -> Void = {
    print("공부 왜해")
}

//클로저 헤더 in 클로저 바디
let studyHarder = { () -> () in
    print("공부 안해")
}

func getStudyWithMe(study: () -> ()) {
    print("주말에도 공부")
    study()
}

// 코드를 전혀 생략하지 않고, 클로저 구문을 사용한 상태, 함수의 매개변수 내에 클로저가 그대로 들어간 형태
// => 인라인(inline) 클로져
getStudyWithMe(study: { () -> () in
    print("공부 안해")
})

// 함수 뒤에 클로저가 실행
// => 트레일링(후행) 클로저
getStudyWithMe() { () -> () in
    print("공부 안해")
}

// (Int) -> String
func example(number: Int) -> String {
    return "\(number)"
}

example(number: Int.random(in: 1...100))

func randomNumber(result: (Int) -> String ) {
    result(Int.random(in: 1...100))
}


// 인라인 클로저
// 함수의 매개변수 안에 클로저가 그대로 들어간 형태
randomNumber(result: { (number: Int) -> String in
    return "나는 \(number)억 만큼 벌거야"
})

// 리턴 타입 생략
randomNumber(result: { (number: Int) in
    return "나는 \(number)억 만큼 벌거야"
})

// 매개변수 타입 생략
randomNumber(result: { (number) in
    return "나는 \(number)억 만큼 벌거야"
})

// 매개변수가 한개면 이름도 생략, in도 생략
// 매개변수명을 사용하지 않는다면 $0, $1
randomNumber(result: {
    return "나는 \($0)억 만큼 벌거야"
})

// Swift 5.1 한줄일 경우 return도 생략
randomNumber(result: {
    "나는 \($0)억 만큼 벌거야"
})

// 후행클로저 처리
randomNumber() {
    "나는 \($0)억 만큼 벌거야"
}

// 후행클로저면 함수 호출 연산자도 생략
randomNumber {
    "나는 \($0)억 만큼 벌거야"
}

let student = [2.2, 4.5, 3.2, 4.9, 3.3, 2.1]

var newStudent: [Double] = []

for item in student {
    if item >= 4.0 {
        newStudent.append(item)
    }
}

let filterStudentt = student.filter { value in
    value >= 4.0
}

let filterStudent = student.filter {
    $0 >= 4.0
}

let number = [Int](1...100)

var newNumber: [Int] = []

for number in number {
    newNumber.append(number * 3)
}

let realNewNumber = number.map { $0 * 3 }

let realNewNumberResult = number.map { "\($0)이다."}

print(realNewNumber)
print(realNewNumberResult)

let movieList = [
    "영화이름": "인셉션",
    "잠": "밤",
    "빕": "낮",
    "이름": "크리스토퍼 놀란",
    "감독": "크리스토퍼 놀란"
]

let movieResult = movieList.first { $0.value == "크리스토퍼 놀란" }
print(movieResult)

let movieMapResult = movieList.first { $0.value == "크리스토퍼 놀란" }.map { $0.key }
print(movieMapResult)
