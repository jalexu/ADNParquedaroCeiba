//
//  RegisterVehicleTests.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//

import XCTest
@testable import Domain

final class RegisterVehicleTests: XCTestCase {
    private var sut: RegisterVehicle!
    private var motorcycle: Motorcycle!
    private var car: Car!
    private var registerDay: Date!

    override func setUpWithError() throws {
        car = DomainTestMock.carMock
        registerDay = DomainTestMock.getRegisterDayMock()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        car = nil
        registerDay = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_getVehicle_whenRegisterWithoutError_ThenReturnCard() throws {
        // Arrange
        sut = try RegisterVehicle(vehicle: car, registerDay: registerDay)
        var resultado: Vehicle? = nil
        
        // Act
        resultado = sut.getVehicle()
        
        // Assert
        XCTAssertNotNil(resultado)
    }
    
    func test_getRegisterDay_whenRegisterWithoutError_ThenReturnRegisterDay() throws {
        // Arrange
        sut = try RegisterVehicle(vehicle: car, registerDay: registerDay)
        var resultado: Date? = nil
        
        // Act
        resultado = sut.getRegisterDay()
        
        // Assert
        XCTAssertNotNil(resultado)
    }
    
    
    func test_initCar_whenIsMondayAndCarHasPlaqueA_ThenRetunException() throws {
        // Arrange
        var resultado: String = ""
        car = DomainTestMock.carPlaqueAMock
        registerDay = DomainTestMock.getDateWithMondayMock()
        
        // Act
        do {
            sut = try RegisterVehicle(vehicle: car, registerDay: registerDay)
        } catch RegisterVehicleError.plaqueAError(let error) {
            resultado = error
        } catch { }
        
        // Assert
            XCTAssertEqual(resultado, "No está autorizado a ingresar.")
        
    }
}
