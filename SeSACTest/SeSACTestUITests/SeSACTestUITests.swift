//
//  SeSACTestUITests.swift
//  SeSACTestUITests
//
//  Created by 김규철 on 2023/12/08.
//

import XCTest

final class SeSACTestUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExampl3() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.textFields["passwordTextField"].tap()
        app.textFields["passwordTextField"].typeText("1231412")
        
        app.textFields["idTextField"].tap()
        app.textFields["idTextField"].typeText("1231412")
        
        app.textFields["emailTextField"].tap()
        app.textFields["emailTextField"].typeText("1231412")
        
        app.buttons["loginButton"].tap()
        
        XCTAssertTrue(app.staticTexts["다음 페이지"].exists, "다음 페이지 글씨 인보임")
    }
    
    func testExampl2() throws { }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.textFields["passwordTextField"].tap()
        app.textFields["passwordTextField"].typeText("1231412")
        
        app.textFields["idTextField"].tap()
        app.textFields["idTextField"].typeText("1231412")
        
        app.textFields["emailTextField"].tap()
        app.textFields["emailTextField"].typeText("1231412")
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
