//: [Previous](@previous)

import UIKit

// 변수나 상수에 메모리 주소값 확인
func address(of object: UnsafeRawPointer) -> String {
    let address = Int(bitPattern: object)
    return String(format: "%p", address)
}

var nickname = "SeSac"

address(of: &nickname)

var newNIckname = nickname

address(of: &newNIckname)

var newNickname2 = nickname

address(of: &newNickname2)

var newNickname3 = nickname

address(of: &newNickname3)

// 원본 데이터를 가져다 쓴다면, 메모리 낭비가 없다.
// 그러나 데이터가 변경된다면 값이 복사되어서 메모리 주소가 바뀐다.
var array = Array(repeating: "kyuchul", count: 300)

// 값이 변경하지 않는다면 같은 메모리를 공유한다.
address(of: &array)

var newArray = array
// 값이 변경하지 않는다면 같은 메모리를 공유한다.
address(of: &newArray)


var newArra2 = array
// 값이 변경하지 않는다면 같은 메모리를 공유한다.
address(of: &newArra2)


newArray[0] = " 헬로"
// 값을 변경한다면 주소값이 변경된다.
address(of: &newArray)


// cow => collection Type (Array, dic, set)
