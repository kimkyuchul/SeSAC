//
//  NetworkMockTestCase.swift
//  SeSACTestTests
//
//  Created by 김규철 on 2023/12/13.
//

import XCTest
@testable import SeSACTest

final class NetworkMockTestCase: XCTestCase {
    
    var sut: NetworkProvider!

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {

    }

    func testExample() throws {
        sut.fetchLotto { lotto in
            print(lotto)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
