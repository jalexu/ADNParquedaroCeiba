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

    override func setUpWithError() throws {
        sut = Motocicle(plaque: "AHDF124", vehicleType: .motocicle, cylinderCapacity: 150)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_validatePlaque_whenMotociclePlaqueInitForA_ThenMessage() throws {
        // Arrange
        var resultado: String = ""
        
        // Act
        resultado = sut.validatePlaque()
        
        // Assert
        XCTAssertEqual(resultado, "No está autorizado a ingresar.")
    }
    
    func test_validatePlaque_whenMotociclePlaqueInitOtherLetter_ThenMessageIsEmpty() throws {
        // Arrange
        var resultado: String = ""
        sut = Motocicle(plaque: "HDF124", vehicleType: .motocicle, cylinderCapacity: 150)
        
        // Act
        resultado = sut.validatePlaque()
        
        // Assert
        XCTAssertTrue(resultado.isEmpty)
    }
    
    func test_getPriceForCylinderCapacity_whenMotocicleHas150CC_ThenReturnValue0() throws {
        // Arrange
        var resultado: Int = 50
        sut = Motocicle(plaque: "HDF124", vehicleType: .motocicle, cylinderCapacity: 150)
        
        // Act
        resultado = sut.getPriceForCylinderCapacity()
        
        // Assert
        XCTAssertEqual(resultado, 0)
    }
    
    func test_getPriceForCylinderCapacity_whenMotocicleHas200CC_ThenReturnValue2000() throws {
        // Arrange
        var resultado: Int = 0
        sut = Motocicle(plaque: "HDF124", vehicleType: .motocicle, cylinderCapacity: 500)
        
        // Act
        resultado = sut.getPriceForCylinderCapacity()
        
        // Assert
        XCTAssertEqual(resultado, 2000)
    }

}
