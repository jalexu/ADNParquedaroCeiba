//
//  CarTests.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 17/03/23.
//

import XCTest
@testable import Domain

final class CarTests: XCTestCase {
    private var sut: Car!

    override func setUpWithError() throws {
        sut = try Car(plaqueId: "AHU990")
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_getPlaqueId_whenCreatedCar_ThenReturnPlaqueId() throws {
        // Arrange
        var resultado: String = ""
        
        // Act
        resultado = sut.getPlaqueId()
        
        // Assert
        XCTAssertEqual(resultado, "AHU990")
    }
}
