//
//  MotorcycleTests.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 17/03/23.
//

import XCTest
@testable import Domain

final class MotorcycleTests: XCTestCase {
    private var sut: Motorcycle!

    override func setUpWithError() throws {
        sut = try Motorcycle(plaqueId: "HJU908", cylinderCapacity: "500")
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_getPlaqueId_whenCreatedMotorcycle_ThenReturnPlaqueId() throws {
        // Arrange
        var resultado: String = ""
        
        // Act
        resultado = sut.getPlaqueId()
        
        // Assert
        XCTAssertEqual(resultado, "HJU908")
    }
    
    func test_getCylinderCapacity_whenCreatedMotorcycle_ThenReturnCylinderCapacity() throws {
        // Arrange
        var resultado: String = ""
        
        // Act
        resultado = sut.getCylinderCapacity()
        
        // Assert
        XCTAssertEqual(resultado, "500")
    }
    
    func test_initMotorcycle_whenCylinderCapacityIsEpty_ThenReturnException() throws {
        // Arrange
        var resultado: String = ""
        
        // Act
        do {
            sut = try Motorcycle(plaqueId: "HJU908", cylinderCapacity: "")
        } catch VehicleError.cylinderCapacity(let error) {
            resultado = error
        }
        
        // Assert
        XCTAssertEqual(resultado, "Debes ingresar el cilindraje de la motocicleta.")
    }
    
    func test_initMotorcycle_WhenPlaqueIsInvalide_ThenThrowException() throws {
        // Arrange
        var resultado: String = ""
        
        // Act
        do {
            sut = try Motorcycle(plaqueId: "tg", cylinderCapacity: "200")
        } catch VehicleError.fieldPlaqueError(let error) {
            resultado = error
        }
        
        // Assert
        XCTAssertEqual(resultado, "Placa incorrecta debe tener 6 caracteres")
    }
    
    func test_initMotorcycle_WhenPlaqueIsEmpty_ThenThrowException() throws {
        // Arrange
        var resultado: String = ""
        
        // Act
        do {
            sut = try Motorcycle(plaqueId: "", cylinderCapacity: "")
        } catch VehicleError.fieldPlaqueError(let error) {
            resultado = error
        }
        
        // Assert
        XCTAssertEqual(resultado, "Ingresa por favor la placa del vehiculo.")
    }
     
}
