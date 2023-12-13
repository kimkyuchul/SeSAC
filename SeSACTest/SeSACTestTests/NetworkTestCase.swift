//
//  NetworkTestCase.swift
//  SeSACTestTests
//
//  Created by 김규철 on 2023/12/13.
//

import XCTest

@testable import SeSACTest

final class NetworkTestCase: XCTestCase {
    
    // 그냥 쓰면 타겟이 다르다 -> @testable import SeSACTest
    var sut: NetworkManager!
    
    // setUpWithError에 항상 새로운 값을 넣어야하기 때문에 초기화하면 안된다.
//    var sut = NetworkManager()
    
    override func setUp() {
    }
    
    override func tearDown() {
    }

    override func setUpWithError() throws {
        sut = NetworkManager.shared
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    // UnitTest는 동기 테스트에 최적화되어있다.
    // fetchLotto의 클로저로 진입하지 않음
    // 비동기 테스트: expectation / fulfill / wait
    func testExample() throws {
        print(1)
        
        let promise = expectation(description: "Lotto number Compltion Handler")
        
        sut.fetchLotto { lotto in
            print(2)
            print(lotto)
            
            var testNumber = 100
            
//            XCTAssertLessThanOrEqual(lotto.bnusNo, 45)
            // 1보다 크거나 같은지
            XCTAssertGreaterThan(lotto.bnusNo, 1)
            
            promise.fulfill() // 정의헤둔 expectation이 충족되는 시점에 호출해서 동작을 수행했음을 알려줌.
        }
        
        wait(for: [promise], timeout: 5) // 비동기 작업을 기다림. 타임아웃 시간이 지나면 실패로 간주
        print(3)
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
