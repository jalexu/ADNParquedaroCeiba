//
//  ExitCarTests.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//

import XCTest
@testable import Domain

final class ExitCarTests: XCTestCase {
    private var sut: ExitCar!
    private var car: Car!
    private var registerDay: Date!
    private var exitDate: Date!

    override func setUpWithError() throws {
        car = DomainTestMock.carMock
        registerDay = DomainTestMock.getDateMock()
        exitDate = Date()
        sut = ExitCar(plaqueId: car.getPlaqueId(), registerDay: registerDay, exitDate: exitDate)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        car = nil
        registerDay = nil
        exitDate = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_getTotalToPay_whenCarHaveTwoHours_ThenMountToPay() throws {
        // Arrange
        var resultado: Int = 0
        
        // Act
        resultado = sut.totalToPay()
        
        // Assert
        XCTAssertEqual(resultado, 2000)
    }
    
    func test_getTotalToPay_whenExitCarHaveOneDay_ThenMountToPay() throws {
        // Arrange
        var resultado: Int = 0
        registerDay = DomainTestMock.getregisterWithDaysMock()
        sut = ExitCar(plaqueId: car.getPlaqueId(), registerDay: registerDay, exitDate: exitDate)
        
        // Act
        resultado = sut.totalToPay()
        
        // Assert
        XCTAssertEqual(resultado, 9000)
    }
    
    func test_getTotalToPay_whenCarHaveFourteenHours_ThenMountToPay() throws {
        // Arrange
        var resultado: Int = 0
        let yestarday: Date = Date()
        sut = ExitCar(plaqueId: car.getPlaqueId(), registerDay: yestarday.addingTimeInterval(-50400), exitDate: exitDate)
        
        // Act
        resultado = sut.totalToPay()
        
        // Assert
        XCTAssertEqual(resultado, 8000)
    }
}
