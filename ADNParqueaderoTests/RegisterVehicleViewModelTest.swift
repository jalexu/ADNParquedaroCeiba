//
//  RegisterVehicleViewModelTest.swift
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 14/03/23.
//

import XCTest
@testable import Infraestructure
@testable import ADNParqueadero

final class RegisterVehicleViewModelTest: XCTestCase {
    private var sut: RegisterVehicleViewModel!
    private var coreDataRepository: CoreDataRepositoryStub!

    override func setUpWithError() throws {
        coreDataRepository = CoreDataRepositoryStub(vehicleObjects: ConstantsMock.vehicles)
        sut = RegisterVehicleViewModel(coreDataRepository: coreDataRepository)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        coreDataRepository = nil
        sut = nil
        try super.tearDownWithError()
    }

    func test_onAppear_whenRetrieveObjectsIsSuccess_ThenNumberOfVehicles() {
        // Arrange
        let expectation = XCTestExpectation(description: "Get vehicles from coreData")
        coreDataRepository = CoreDataRepositoryStub(vehicleObjects: ConstantsMock.vehicles)
        sut = RegisterVehicleViewModel(coreDataRepository: coreDataRepository)
        
        coreDataRepository.responseHandler = .success {
            ConstantsMock.vehicles
        }
        
        // Act
        sut.onAppear()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.numersOfCars, 1)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_onAppear_whenRetrieveObjectsIsFailure_ThenNumberOfVehiclesAreZero() {
        // Arrange
        let expectation = XCTestExpectation(description: "Get error from coreData")
        
        coreDataRepository.responseHandler = .failure({
            NSError(domain:"Data does't exist", code: 500, userInfo:nil)
        })
        
        // Act
        sut.onAppear()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.numersOfCars, 0)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_registerVehicle_whenInputPlaqueIsEmpty_ThenShowAlert() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show alert")
        coreDataRepository = CoreDataRepositoryStub(vehicleObjects: ConstantsMock.vehicles)
        sut = RegisterVehicleViewModel(coreDataRepository: coreDataRepository)
        
        coreDataRepository.responseHandler = .success {
            ConstantsMock.vehicles
        }
        
        // Act
        sut.registerVehicle()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.showAlert)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_registerVehicle_whenInputPlaqueInfoIsCompleted_ThenIsSuccess() {
        // Arrange
        let expectation = XCTestExpectation(description: "Register is completed")
        coreDataRepository = CoreDataRepositoryStub(vehicleObjects: ConstantsMock.vehicles)
        sut = RegisterVehicleViewModel(coreDataRepository: coreDataRepository)
        
        coreDataRepository.responseHandler = .success {
            ConstantsMock.vehicles
        }
        
        sut.state.inputPlaque = "AHN677"
        sut.state.inputVehicleType = "Car"
        
        // Act
        sut.registerVehicle()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.loading)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_registerVehicle_whenInputPlaqueInfoIsCompleted_ThenIsError() {
        // Arrange
        let expectation = XCTestExpectation(description: "Register has error")
        
        coreDataRepository.responseHandler = .failure({
            NSError(domain:"Data does't exist", code: 500, userInfo:nil)
        })
        
        sut.state.inputPlaque = "AHN657"
        sut.state.inputVehicleType = "Motocicle"
        
        // Act
        sut.registerVehicle()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.message, "Error al guardar")
        } else {
            XCTFail("Delay interrupted")
        }
    }
}
