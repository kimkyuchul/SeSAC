//
//  Endpoint.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import Foundation

// 열거형은 인스턴스를 생성 불가
enum Nasa: String, CaseIterable {
    
    static let baseURL = "https://apod.nasa.gov/apod/image/"
    
    case one = "2308/sombrero_spitzer_3000.jpg"
    case two = "2212/NGC1365-CDK24-CDK17.jpg"
    case three = "2307/M64Hubble.jpg"
    case four = "2306/BeyondEarth_Unknown_3000.jpg"
    case five = "2307/NGC6559_Block_1311.jpg"
    case six = "2304/OlympusMons_MarsExpress_6000.jpg"
    case seven = "2305/pia23122c-16.jpg"
    case eight = "2308/SunMonster_Wenz_960.jpg"
    case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
    
    // 열거형은 저장 프로퍼티를 만들지 못한다.
    // 연산 프로퍼티의 특성 -> 저장을 하고 있진 않다.
    // 값을 저장하고 있지는 않고, 값을 사용할 수 있는 통로로서의 역할만 담당한다.
    // test를 호출하는 곳에서 결과괎을 저장하기 때문 -> 열거형에선 어떠한 내용도 가지고 있지 않다.
    // static이든 그냥 인스턴스든 통로로써의 역할만 한다.
    var test: URL {
        return URL(string: "test")!
    }
    
    // static을 빼면 오류가 난다.
    // 연산 프로퍼티 안에서 사용하려는 애들이 타입 프로퍼티로 구현되어 있기 때문에
    // 나의 역할은 인스턴스 연산 프로퍼티인데 안에 애들은 타입임
    static var photo: URL {
        return URL(string: baseURL + self.allCases.randomElement()!.rawValue)!
    }
    // 안에서 타입 프로퍼티를 쓰지만 testPhoto라는 프로퍼티는 연산 프로퍼티로 만들고 싶다면,
    // 안에 타입 프로퍼티들에 타입을 붙여주면(Nasa) 문제가 없다. test를 호출하는 곳에서 즉, 사용될 떄 타입프로퍼티들의 값도 반환되기 때문이다.
    var testPhoto: URL {
        return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
    }
}
