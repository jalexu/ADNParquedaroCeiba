//
//  RegisterMotocicleTests.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//

import XCTest
@testable import Domain

final class RegisterMotocicleTests: XCTestCase {
    private var sut: RegisterMotocicle!
    private var motocicle: Motocicle!
    private var registerDay: Date!

    override func setUpWithError() throws {
        motocicle = DomainTestMock.motocicleMock
        registerDay = DomainTestMock.getRegisterDayMock()
        sut = try RegisterMotocicle(motocicle: motocicle, registerDay: registerDay, numberMotocicle: 0)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        motocicle = nil
        registerDay = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_getMotocicle_whenRegisterWithoutError_ThenReturnCard() throws {
        // Arrange
        var resultado: Motocicle? = nil
        
        // Act
        resultado = sut.getMotocicle()
        
        // Assert
        XCTAssertNotNil(resultado)
    }
    
    func test_initMotocicle_whenParqueaderoIsFull_ThenRetunException() throws {
        // Arrange
        var resultado: String = ""
        
        // Act
        do {
            try sut = RegisterMotocicle(motocicle: motocicle, registerDay: registerDay, numberMotocicle: 10)
        } catch VehicleError.exceedNumberVehicles(let error) {
            resultado = error
        }
        
        // Assert
        XCTAssertEqual(resultado, "El parquedaro no puede recibir más motos.")
    }
    
    func test_initMotocicle_whenIsMondayAndCarHasPlaqueA_ThenRetunException() throws {
        // Arrange
        var resultado: String = ""
        motocicle = DomainTestMock.motociclePlaqueAMock
        registerDay = DomainTestMock.getDateWithMondayMock()
        
        // Act
        do {
            try sut = RegisterMotocicle(motocicle: motocicle, registerDay: registerDay, numberMotocicle: 1)
        } catch VehicleError.plaqueAError(let error) {
            resultado = error
        }
        
        // Assert
        XCTAssertEqual(resultado, "No está autorizado a ingresar.")
    }

}
