//
//  ExitMotorcycleTests.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//

import XCTest
@testable import Domain

final class ExitMotorcycleTests: XCTestCase {
    private var sut: ExitMotorcycle!
    private var registerDay: Date!
    private var exitDate: Date!

    override func setUpWithError() throws {
        registerDay = DomainTestMock.getRegisterDayMock()
        exitDate = Date()
        sut = ExitMotorcycle(plaqueId: "ADFF", registerDay: registerDay, exitDate: exitDate, cylinderCapacity: "200")
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        exitDate = nil
        registerDay = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_GetTotalToPay_WhenMotocicleHasTwoHours_ThenMountToPay() throws {
        // Arrange
        var resultado: Int = 0
        
        // Act
        resultado = sut.totalToPay()
        
        // Assert
        XCTAssertEqual(resultado, 1000)
    }
    
    func test_GetTotalToPay_WhenMotocicleHasTwoHoursAnd600CC_ThenMountToPay() throws {
        // Arrange
        var resultado: Int = 0
        sut = ExitMotorcycle(plaqueId: "TYDDD", registerDay: registerDay, exitDate: exitDate, cylinderCapacity: "600")
        // Act
        resultado = sut.totalToPay()
        
        // Assert
        XCTAssertEqual(resultado, 3000)
    }
    
    func test_GetTotalToPay_WhenExitMotocicleHasOneDay_ThenMountToPay() throws {
        // Arrange
        var resultado: Int = 0
        registerDay = DomainTestMock.getregisterWithDaysMock()
        
        sut = ExitMotorcycle(plaqueId: "TYDDD", registerDay: registerDay, exitDate: exitDate, cylinderCapacity: "300")
        
        // Act
        resultado = sut.totalToPay()
        
        // Assert
        XCTAssertEqual(resultado, 4500)
    }
    
    func test_GetTotalToPay_ghenMotocicleHasFourteenHours_ThenMountToPay() throws {
        // Arrange
        var resultado: Int = 0
        let yestarday: Date = Date()
        sut = ExitMotorcycle(plaqueId: "TYDDD", registerDay: yestarday.addingTimeInterval(-50400), exitDate: exitDate, cylinderCapacity: "400")
        
        // Act
        resultado = sut.totalToPay()
        
        // Assert
        XCTAssertEqual(resultado, 4000)
    }
}
