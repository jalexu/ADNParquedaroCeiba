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
        sut = Car(plaque: "AHDF123", vehicleType: .car)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_validatePlaque_whenCarPlaqueInitForA_ThenMessage() throws {
        // Arrange
        var resultado: String = ""
        
        // Act
        resultado = sut.validatePlaque()
        
        // Assert
        XCTAssertEqual(resultado, "No está autorizado a ingresar.")
    }
    
    func test_validatePlaque_whenCarPlaqueInitOtherLetter_ThenMessageIsEmpty() throws {
        // Arrange
        var resultado: String = ""
        sut = Car(plaque: "HDF123", vehicleType: .car)
        
        // Act
        resultado = sut.validatePlaque()
        
        // Assert
        XCTAssertTrue(resultado.isEmpty)
    }
}
