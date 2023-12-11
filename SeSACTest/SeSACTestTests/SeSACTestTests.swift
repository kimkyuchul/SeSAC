//
//  SeSACTestTests.swift
//  SeSACTestTests
//
//  Created by 김규철 on 2023/12/08.
//

import XCTest
@testable import SeSACTest

//LoginVC 내 valid 메서드
final class SeSACTestTests: XCTestCase {
    
    var sut: LoginViewController! // 시스템이 테스트를 하려는 대상(system under test)

    override func setUpWithError() throws {
        print(#function)
        // 테스트 시작 전 값 세팅
        let sb = UIStoryboard(name: "Login", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        sut = vc
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        print(#function)
        // 테스트 이후 초기화(nil)
        sut = nil
    }
    
    // 테스트
    func testLoginViewController_ValidEmail_ReturnTrue() throws {
        print(#function)
        sut.idTextField.text = "kyuchul@test.com"
        
        XCTAssertTrue(sut.isValidEmail(), "@ 없거나 6글자 미만")
    }
    
    // 테스트 결과가 성공이지만, 사실 실패 케이스를 테스트 한것
    func testLoginViewController_ValidEmail_ReturnFalse() throws {
        print(#function)
        sut.idTextField.text = "kyuchultest.com"
        // isValidEmail에서 false가 나오는게 테스트 입장에서는 성공 -> 실패 케이스를 테스트 하는거니까
        XCTAssertFalse(sut.isValidEmail(), "@ 없거나 6글자 미만")
    }
    
    func testLoginViewCOntroller_Testing_ReturnNil() throws {
        sut.idTextField = nil
        XCTAssertNil(sut.idTextField, "Nil")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
