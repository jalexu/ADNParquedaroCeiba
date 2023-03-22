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
    private var date: Date!

    override func setUpWithError() throws {
        date = DomainTestMock.getDateMock()
        sut = Car(plaque: "AHDF123", vehicleType: .car, registerDate: DomainTestMock.getDateWithMondayMock())
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        date = nil
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
        sut = Car(plaque: "HDF123", vehicleType: .car, registerDate: DomainTestMock.getDateMock())
        
        // Act
        resultado = sut.validatePlaque()
        
        // Assert
        XCTAssertTrue(resultado.isEmpty)
    }
}
