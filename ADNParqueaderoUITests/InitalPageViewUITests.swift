//
//  InitalPageViewUITests.swift
//  ADNParqueaderoUITests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 14/03/23.
//

import XCTest

final class InitalPageViewUITests: XCTestCase {
    var app: XCUIApplication!
    

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }

    func test_registerNavigationLink_exist() throws {
        let timeout = 1.0
        let button = app.buttons["registerNavigationLink"]
        XCTAssertTrue(button.waitForExistence(timeout: timeout))
        button.tap()
    }
    
    func test_paymentNavigationLink_exist() throws {
        let timeout = 1.0
        let button = app.buttons["paymentNavigationLink"]
        XCTAssertTrue(button.waitForExistence(timeout: timeout))
        button.tap()
    }
}
