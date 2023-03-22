//
//  RegisterVehicleViewModelTest.swift
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 14/03/23.
//

import XCTest
@testable import ADNParqueadero

final class RegisterVehicleViewModelTest: XCTestCase {
    private var isTestInitial: Bool!
    private var sut: RegisterVehicleViewModel!

    override func setUpWithError() throws {
        isTestInitial = true
        //sut = RegisterVehicleViewModel()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        isTestInitial = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        XCTAssertTrue(isTestInitial)
    }
}
