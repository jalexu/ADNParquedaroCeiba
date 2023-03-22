//
//  MotocicleTests.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 17/03/23.
//

import XCTest
@testable import Domain

final class MotocicleTests: XCTestCase {
    private var sut: Motocicle!
    private var date: Date!

    override func setUpWithError() throws {
        date = DomainTestMock.getDateMock()
        sut = Motocicle(plaque: "AHDF124", vehicleType: .motocicle, cylinderCapacity: "150", registerDate: date)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        date = nil
        sut = nil
        try super.tearDownWithError()
    }

    func test_validatePlaque_whenMotociclePlaqueInitForA_ThenMessage() throws {
        // Arrange
        var resultado: String = ""
        sut = Motocicle(plaque: "AHDF124", vehicleType: .motocicle, cylinderCapacity: "150", registerDate:  DomainTestMock.getDateWithMondayMock())
        // Act
        
        resultado = sut.validatePlaque()
        
        // Assert
        XCTAssertEqual(resultado, "No está autorizado a ingresar.")
    }
    
    func test_validatePlaque_whenMotociclePlaqueInitOtherLetter_ThenMessageIsEmpty() throws {
        // Arrange
        var resultado: String = ""
        sut = Motocicle(plaque: "HDF124", vehicleType: .motocicle, cylinderCapacity: "150", registerDate: date)
        
        // Act
        resultado = sut.validatePlaque()
        
        // Assert
        XCTAssertTrue(resultado.isEmpty)
    }
    
    func test_getPriceForCylinderCapacity_whenMotocicleHas150CC_ThenReturnValue0() throws {
        // Arrange
        var resultado: Int = 50
        sut = Motocicle(plaque: "HDF124", vehicleType: .motocicle, cylinderCapacity: "150", registerDate: date)
        
        // Act
        resultado = sut.getPriceForCylinderCapacity()
        
        // Assert
        XCTAssertEqual(resultado, 0)
    }
    
    func test_getPriceForCylinderCapacity_whenMotocicleHas200CC_ThenReturnValue2000() throws {
        // Arrange
        var resultado: Int = 0
        sut = Motocicle(plaque: "HDF124", vehicleType: .motocicle, cylinderCapacity: "500", registerDate: date)
        
        // Act
        resultado = sut.getPriceForCylinderCapacity()
        
        // Assert
        XCTAssertEqual(resultado, 2000)
    }
}
