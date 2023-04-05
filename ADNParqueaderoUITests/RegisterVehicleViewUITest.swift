//
//  RegisterVehicleViewUITest.swift
//  ADNParqueaderoUITests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 5/04/23.
//

import XCTest

final class RegisterVehicleViewUITest: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }

    func test_registerNavigationLink_whenInputPlaque() throws {
        let button = app.buttons["registerNavigationLink"]
        button.tap()
        
        let inputPlaque = app.textFields["inputPlaque"]
        inputPlaque.tap()
        inputPlaque.typeText("ASD123")
        XCTAssertEqual(inputPlaque.value as? String, "ASD123")
    }

    func test_registerButtonView_whenSelectTypeVehicle_exist() throws {
        let timeout = 0.5
        let button = app.buttons["registerNavigationLink"]
        button.tap()
        
        sleep(1)
        
        let registerButton = app.buttons["registerButtonView"]
        XCTAssertTrue(registerButton.waitForExistence(timeout: timeout))
    }
}
