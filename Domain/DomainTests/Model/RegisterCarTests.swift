//
//  RegisterCarTests.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//

import XCTest
@testable import Domain

final class RegisterCarTests: XCTestCase {
    private var sut: RegisterCar!
    private var car: Car!
    private var registerDay: Date!

    override func setUpWithError() throws {
        car = DomainTestMock.carMock
        registerDay = DomainTestMock.getDateMock()
        sut = try RegisterCar(car: car, registerDay: registerDay, numberCars: 0)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        car = nil
        registerDay = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_getCar_whenRegisterWithoutError_ThenReturnCard() throws {
        // Arrange
        var resultado: Car? = nil
        
        // Act
        resultado = sut.getCar()
        
        // Assert
        XCTAssertNotNil(resultado)
    }
    
    func test_initCar_whenParqueaderoIsFull_ThenRetunException() throws {
        // Arrange
        var resultado: String = ""
        
        // Act
        do {
            try sut = RegisterCar(car: car, registerDay: registerDay, numberCars: 20)
        } catch VehicleError.exceedNumberVehicles(let error) {
            resultado = error
        }
        
        // Assert
        XCTAssertEqual(resultado, "El parquedaro no puede recibir mas carros.")
    }
    
    func test_initCar_whenIsMondayAndCarHasPlaqueA_ThenRetunException() throws {
        // Arrange
        var resultado: String = ""
        car = DomainTestMock.carPlaqueAMock
        registerDay = DomainTestMock.getDateWithMondayMock()
        
        // Act
        do {
            try sut = RegisterCar(car: car, registerDay: registerDay, numberCars: 1)
        } catch VehicleError.plaqueAError(let error) {
            resultado = error
        } catch {}
        
        // Assert
        XCTAssertEqual(resultado, "No está autorizado a ingresar.")
    }

}
