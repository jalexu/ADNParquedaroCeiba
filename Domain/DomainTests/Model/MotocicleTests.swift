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
        sut = try Motocicle(plaqueId: "HJU908", cylinderCapacity: "500")
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_getPlaqueId_whenCreatedMotocicle_ThenReturnPlaqueId() throws {
        // Arrange
        var resultado: String = ""
        
        // Act
        resultado = sut.getPlaqueId()
        
        // Assert
        XCTAssertEqual(resultado, "HJU908")
    }
    
    func test_getCylinderCapacity_whenCreatedMotocicle_ThenReturnCylinderCapacity() throws {
        // Arrange
        var resultado: String = ""
        
        // Act
        resultado = sut.getCylinderCapacity()
        
        // Assert
        XCTAssertEqual(resultado, "500")
    }
    
    func test_initMotocicle_whenCylinderCapacityIsEpty_ThenReturnException() throws {
        // Arrange
        var resultado: String = ""
        
        // Act
        do {
            sut = try Motocicle(plaqueId: "HJU908", cylinderCapacity: "")
        } catch VehicleError.cylinderCapacity(let error) {
            resultado = error
        }
        
        // Assert
        XCTAssertEqual(resultado, "Debes ingresar el cilindraje de la motocicleta.")
    }
     
}
