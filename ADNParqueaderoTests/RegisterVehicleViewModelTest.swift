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
    private var carService: CarServiceStub!
    private var motocicleService: MotocicleServiceStub!
    
    override func setUpWithError() throws {
        carService = CarServiceStub(vehicleObjects: ConstantsMock.registerCars)
        motocicleService = MotocicleServiceStub(vehicleObjects: ConstantsMock.registerMotocicles)
        sut = RegisterVehicleViewModel(carService: carService, motocicleService: motocicleService)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        carService = nil
        motocicleService = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_onAppear_WhenRetrieveCarObjectsIsSuccess_ThenNumberOfVehicles() {
        // Arrange
        let expectation = XCTestExpectation(description: "Get vehicles from coreData")
        
        carService.responseHandler = .success {
            ConstantsMock.registerCars
        }
        
        sut.state.seletedVehicleType = .car
        
        // Act
        sut.onAppear()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.numersOfCars, 2)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_onAppear_whenRetrieveCarObjectsIsFailure_ThenNumberOfVehiclesAreZero() {
        // Arrange
        let expectation = XCTestExpectation(description: "Get error from coreData")
        
        carService.responseHandler = .failure({
            NSError(domain:"Data does't exist", code: 500, userInfo:nil)
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
        
        carService.responseHandler = .success {
            ConstantsMock.registerCars
        }
        
        motocicleService.responseHandler = .success {
            ConstantsMock.registerMotocicles
        }
        
        sut.state.seletedVehicleType = .motocicle
        
        // Act
        sut.onAppear()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.numersOfMotocicles, 2)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_onAppear_whenRetrieveMotocicleObjectsIsFailure_ThenNumberOfVehiclesAreZero() {
        // Arrange
        let expectation = XCTestExpectation(description: "Get error from coreData")
        
        carService.responseHandler = .failure({
            NSError(domain:"Data does't exist", code: 500, userInfo:nil)
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
    
    func test_registerVehicle_WhenIsACar_ThenIsSuccess() {
        // Arrange
        let expectation = XCTestExpectation(description: "Register has success")
        sut.state.inputPlaque = "AHN657"
        sut.state.seletedVehicleType = .car
        
        carService.responseHandler = .success {
            ConstantsMock.registerCars
        }
        
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
    
    func test_registerVehicle_WhenIsACar_ThenIsError() {
        // Arrange
        let expectation = XCTestExpectation(description: "Register has error")
        sut.state.inputPlaque = "AHN657"
        sut.state.seletedVehicleType = .car
        
        carService.responseHandler = .failure({
            NSError(domain:"Data does't exist", code: 500, userInfo:nil)
        })
        
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
    
    func test_registerVehicle_WhenIsAMotocicle_ThenIsSuccess() {
        // Arrange
        let expectation = XCTestExpectation(description: "Register has success")
        sut.state.inputPlaque = "AHN657"
        sut.state.seletedVehicleType = .motocicle
        
        motocicleService.responseHandler = .success {
            ConstantsMock.registerMotocicles
        }
        
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
    
    func test_registerVehicle_WhenIsAMotocicle_ThenIsError() {
        // Arrange
        let expectation = XCTestExpectation(description: "Register has error")
        sut.state.inputPlaque = "AHN657"
        sut.state.seletedVehicleType = .motocicle
        
        motocicleService.responseHandler = .failure({
            NSError(domain:"Data does't exist", code: 500, userInfo:nil)
        })
        
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
    
    func test_registerVehicle_WhenIsCarAndInputPlaqueIsEmpty_ThenShowAlert() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show alert")
        sut.state.inputPlaque = ""
        
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
    
    func test_registerVehicle_WhenIsCarAndParkingIsFull_ThenShowAlert() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show alert")
        sut.state.numersOfCars = 20
        sut.state.inputPlaque = "LFG678"
        
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
    
    func test_registerVehicle_WhenIsCarAndInputPlaqueIsIncompleted_ThenShowAlert() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show alert")
        sut.state.inputPlaque = "ASD"
        sut.state.seletedVehicleType = .car
        
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
    
    func test_registerVehicle_WhenIsMotocicleAndParkingIsFull_ThenShowAlert() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show alert")
        sut.state.numersOfMotocicles = 10
        sut.state.inputPlaque = "GFG678"
        sut.state.seletedVehicleType = .motocicle
        
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
    
    func test_registerVehicle_WhenIsMotocicleAndInputPlaqueIsEmpty_ThenShowAlert() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show alert")
        sut.state.inputPlaque = ""
        sut.state.seletedVehicleType = .motocicle
        
        motocicleService.responseHandler = .success {
            ConstantsMock.registerMotocicles
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
    
    func test_registerVehicle_WhenIsMotocicleAndInputPlaqueIsIncompleted_ThenShowAlert() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show alert")
        sut.state.inputPlaque = "ALK"
        sut.state.seletedVehicleType = .motocicle
        
        motocicleService.responseHandler = .success {
            ConstantsMock.registerMotocicles
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

}
