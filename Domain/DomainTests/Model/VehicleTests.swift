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
    private var date: Date!

    override func setUpWithError() throws {
        date = DomainTestMock.getDateMock()
        sut = Vehicle(plaque: "AHDF123", vehicleType: .car, registerDate: date)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_validatePlaque_whenVehiclePlaqueInitForA_ThenMessage() throws {
        // Arrange
        var resultado: String = ""
        sut = Vehicle(plaque: "AHDF123", vehicleType: .car, registerDate: DomainTestMock.getDateWithMondayMock())
        
        // Act
        resultado = sut.validatePlaque()
        
        // Assert
        XCTAssertEqual(resultado, "No está autorizado a ingresar.")
    }
    
    func test_validatePlaque_whenVehiclePlaqueInitForAButDayIsValid_ThenDoesntShowMessage() throws {
        // Arrange
        var resultado: String = ""
        
        // Act
        resultado = sut.validatePlaque()
        
        // Assert
        XCTAssertEqual(resultado, "")
    }
    
    func test_validatePlaque_whenVehiclePlaqueInitOtherLetter_ThenMessageIsEmpty() throws {
        // Arrange
        var resultado: String = ""
        sut = Vehicle(plaque: "HDF123", vehicleType: .car, registerDate: date)
        
        // Act
        resultado = sut.validatePlaque()
        
        // Assert
        XCTAssertTrue(resultado.isEmpty)
    }
    
    func test_getCylinderCapacity_whenVehicleHasCylinder_ThenReturnCapacity() throws {
        // Arrange
        var resultado: String? = "0"
        sut = Vehicle(plaque: "HDF123", vehicleType: .car, cylinderCapacity: "200", registerDate: date)
        
        // Act
        resultado = sut.getCylinderCapacity()
        
        // Assert
        XCTAssertEqual(resultado, "200")
    }
    
    func test_getRegisterDate_whenRegisterDate_ThenDate() throws {
        // Arrange
        var resultado: Date? = nil
        sut = Vehicle(plaque: "HDF123", vehicleType: .car, cylinderCapacity: "200", registerDate: date)
        
        // Act
        resultado = sut.getRegisterDate()
        
        // Assert
        XCTAssertEqual(resultado, date)
    }
}
