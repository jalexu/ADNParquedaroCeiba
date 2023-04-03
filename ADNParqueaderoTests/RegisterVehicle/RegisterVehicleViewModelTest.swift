//
//  RegisterVehicleViewModelTest.swift
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 14/03/23.
//

import XCTest
@testable import Infraestructure
@testable import Domain
@testable import ADNParqueadero

final class RegisterVehicleViewModelTest: XCTestCase {
    private var sut: RegisterVehicleViewModel!
    private var registerVehicleService: RegisterVehicleServiceStub!
    
    override func setUpWithError() throws {
        registerVehicleService = try RegisterVehicleServiceStub(vehicles: ConstantsMock.registerVehiclesWithCarMock())
        sut = RegisterVehicleViewModel(registarVehicleService: registerVehicleService)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        registerVehicleService = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_onAppear_WhenRetrieveCarObjectsIsSuccess_ThenNumberOfVehicles() {
        // Arrange
        let expectation = XCTestExpectation(description: "Get vehicles from coreData")
        
        registerVehicleService.responseHandler = .success {
            ConstantsMock.registerVehiclesWithCarMock
        }
        
        sut.state.seletedVehicleType = .car
        
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
    
    func test_onAppear_whenRetrieveCarObjectsIsFailure_ThenNumberOfVehiclesAreZero() {
        // Arrange
        let expectation = XCTestExpectation(description: "Get error from coreData")
        
        registerVehicleService.responseHandler = .failure({
            NSError(domain: "Data does't exist", code: 500, userInfo: nil)
        })
        
        sut.state.seletedVehicleType = .car
        
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
    
    func test_onAppear_WhenRetrieveMotocicleObjectsIsSuccess_ThenNumberOfVehicles() {
        // Arrange
        let expectation = XCTestExpectation(description: "Get vehicles from coreData")
        
        registerVehicleService.responseHandler = .success {
            ConstantsMock.registerVehiclesWithCarMock
        }
        
        registerVehicleService.responseHandler = .success {
            ConstantsMock.registerVehiclesWithMotorcycles
        }
        
        sut.state.seletedVehicleType = .motocicle
        
        // Act
        sut.onAppear()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.numersOfMotocicles, 0)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_onAppear_whenRetrieveMotocicleObjectsIsFailure_ThenNumberOfVehiclesAreZero() {
        // Arrange
        let expectation = XCTestExpectation(description: "Get error from coreData")
        
        registerVehicleService.responseHandler = .failure({
            NSError(domain: "Data does't exist", code: 500, userInfo: nil)
        })
        
        sut.state.seletedVehicleType = .motocicle
        
        // Act
        sut.onAppear()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.numersOfMotocicles, 0)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_registerCar_WhenDBResponse_ThenIsSuccess() {
        // Arrange
        let expectation = XCTestExpectation(description: "Register has success")
        sut.state.inputPlaque = "AHN657"
        sut.state.seletedVehicleType = .car
        
        registerVehicleService.responseHandler = .success {
            ConstantsMock.registerVehiclesWithCarMock
        }
        
        // Act
        sut.registerVehicle { }
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.loading)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_registerCar_WhenDBHasError_ThenIsError() {
        // Arrange
        let expectation = XCTestExpectation(description: "Register has error")
        sut.state.inputPlaque = "BHN657"
        sut.state.seletedVehicleType = .car
        
        registerVehicleService.responseHandler = .failure({
            NSError(domain: "Data does't exist", code: 500, userInfo: nil)
        })
        
        // Act
        sut.registerVehicle { }
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.message, "Error al guardar")
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_registerMotocicle_WhenDBResponse_ThenIsSuccess() {
        // Arrange
        let expectation = XCTestExpectation(description: "Register has success")
        sut.state.inputPlaque = "AHN657"
        sut.state.seletedVehicleType = .motocicle
        
        registerVehicleService.responseHandler = .success {
            ConstantsMock.registerVehiclesWithMotorcycles
        }
        
        // Act
        sut.registerVehicle { }
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.loading)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_registerMotocicle_WhenDBHasError_ThenIsError() {
        // Arrange
        let expectation = XCTestExpectation(description: "Register has error")
        sut.state.inputPlaque = "PHN657"
        sut.state.seletedVehicleType = .motocicle
        sut.state.inputCylinderCapacity = "200"
        
        registerVehicleService.responseHandler = .failure({
            NSError(domain: "Data does't exist", code: 500, userInfo: nil)
        })
        
        // Act
        sut.registerVehicle(completion: {})
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.message, "Error al guardar")
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_registerCar_WhenInputPlaqueIsEmpty_ThenShowAlert() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show alert")
        sut.state.inputPlaque = ""
        
        // Act
        sut.registerVehicle(completion: {})
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.showAlert)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_registerCar_WhenParkingIsFull_ThenShowAlert() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show alert")
        sut.state.numersOfCars = 20
        sut.state.inputPlaque = "LFG678"
        
        // Act
        sut.registerVehicle(completion: {})
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.showAlert)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_registerCar_WhenInputPlaqueIsIncompleted_ThenShowAlert() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show alert")
        sut.state.inputPlaque = "ASD"
        sut.state.seletedVehicleType = .car
        
        // Act
        sut.registerVehicle(completion: {})
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.showAlert)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_registerMotocicle_WhenParkingIsFull_ThenShowAlert() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show alert")
        sut.state.numersOfMotocicles = 10
        sut.state.inputPlaque = "GFG678"
        sut.state.seletedVehicleType = .motocicle
        
        // Act
        sut.registerVehicle(completion: {})
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.showAlert)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_registerMotocicle_WhenInputPlaqueIsEmpty_ThenShowAlert() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show alert")
        sut.state.inputPlaque = ""
        sut.state.seletedVehicleType = .motocicle
        
        registerVehicleService.responseHandler = .success {
            ConstantsMock.registerVehiclesWithMotorcycles
        }
        
        // Act
        sut.registerVehicle(completion: {})
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.showAlert)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_registerMotocicle_WhenIsInputPlaqueIsIncompleted_ThenShowAlert() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show alert")
        sut.state.inputPlaque = "ALK"
        sut.state.seletedVehicleType = .motocicle
        
        registerVehicleService.responseHandler = .success {
            ConstantsMock.registerVehiclesWithMotorcycles
        }
        
        // Act
        sut.registerVehicle(completion: {})
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.showAlert)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_registerMotocicle_WhenCilynderCapacityIsEmpty_ThenShowAlert() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show alert")
        sut.state.numersOfMotocicles = 10
        sut.state.inputPlaque = "GFG678"
        sut.state.seletedVehicleType = .motocicle
        
        // Act
        sut.registerVehicle(completion: {})
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.showAlert)
        } else {
            XCTFail("Delay interrupted")
        }
    }

}
