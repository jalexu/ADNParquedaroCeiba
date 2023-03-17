//
//  VehicleTests.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 17/03/23.
//

import XCTest
@testable import Domain

final class VehicleTests: XCTestCase {
    private var sut: Vehicle!

    override func setUpWithError() throws {
        sut = Vehicle(plaque: "AHDF123", vehicleType: .car)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_validatePlaque_whenVehiclePlaqueInitForA_ThenMessage() throws {
        // Arrange
        var resultado: String = ""
        
        // Act
        resultado = sut.validatePlaque()
        
        // Assert
        XCTAssertEqual(resultado, "No está autorizado a ingresar.")
    }
    
    func test_validatePlaque_whenVehiclePlaqueInitOtherLetter_ThenMessageIsEmpty() throws {
        // Arrange
        var resultado: String = ""
        sut = Vehicle(plaque: "HDF123", vehicleType: .car)
        
        // Act
        resultado = sut.validatePlaque()
        
        // Assert
        XCTAssertTrue(resultado.isEmpty)
    }
    
    func test_getCylinderCapacity_whenVehicleHasCylinder_ThenReturnCapacity() throws {
        // Arrange
        var resultado: Int? = 0
        sut = Vehicle(plaque: "HDF123", vehicleType: .car, cylinderCapacity: 200)
        
        // Act
        resultado = sut.getCylinderCapacity()
        
        // Assert
        XCTAssertEqual(resultado, 200)
    }
    
    
}
