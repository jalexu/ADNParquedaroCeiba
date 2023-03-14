//
//  ADNParqueaderoTests.swift
//  ADNParqueaderoTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 14/03/23.
//

import XCTest
@testable import ADNParqueadero

final class ADNParqueaderoTests: XCTestCase {
    var isTestInitial: Bool!

    override func setUpWithError() throws {
        isTestInitial = true
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
