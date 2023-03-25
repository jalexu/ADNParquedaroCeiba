//
//  PaymentParkingViewModelTest.swift
//  ADNParqueaderoTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//

import XCTest
@testable import Infraestructure
@testable import Domain
@testable import ADNParqueadero

final class PaymentParkingViewModelTest: XCTestCase {
    private var sut: PaymentParkingViewModel!
    private var carService: CarServiceStub!
    private var motocicleService: MotocicleServiceStub!
    
    override func setUpWithError() throws {
        carService = CarServiceStub(vehicleObjects: ConstantsMock.registerCars)
        motocicleService = MotocicleServiceStub(vehicleObjects: ConstantsMock.registerMotocicles)
        sut = PaymentParkingViewModel(carService: carService, motocicleService: motocicleService)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        carService = nil
        motocicleService = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_searchVehicle_WhenRetrieveCarObjectIsSuccess_ThenShowValue() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .car
        
        carService.responseHandler = .success {
            ConstantsMock.registerCars
        }
        
        carService.exitCarObject = ExitCar(plaqueId: "ASF890",
                                           registerDay: ConstantsMock.getDateMock(),
                                           exitDate: Date())
         
        // Act
        sut.searchVehicle(numberPlaque: "ASF890")
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.valueToPay, 2000)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_searchVehicle_WhenRetrieveCarObjectIsError_ThenShowError() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .car
        
        carService.responseHandler = .failure({
            NSError(domain:"Data does't exist", code: 500, userInfo:nil)
        })
        
        // Act
        sut.searchVehicle(numberPlaque: "ASF890")
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.showError)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_searchVehicle_WhenRetrieveMotocicleObjectIsSuccess_ThenShowValue() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .motocicle
        
        motocicleService.responseHandler = .success {
            ConstantsMock.registerMotocicles
        }
        
        motocicleService.exitMotocicleObject = .init(
            plaqueId: "THD785",
            registerDay: ConstantsMock.getDateMock(),
            exitDate: Date(),
            cylinderCapacity: "200")
        
        // Act
        sut.searchVehicle(numberPlaque: "THD785")
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.valueToPay, 1000)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_searchVehicle_WhenRetrieveMotocicleObjectWith600CCIsSuccess_ThenShowValue() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .motocicle
        
        motocicleService.responseHandler = .success {
            ConstantsMock.registerMotocicles
        }
        
        motocicleService.exitMotocicleObject = .init(
            plaqueId: "FHD785",
            registerDay: ConstantsMock.getDateMock(),
            exitDate: Date(),
            cylinderCapacity: "600")
        
        // Act
        sut.searchVehicle(numberPlaque: "FHD785")
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.valueToPay, 3000)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_searchVehicle_WhenRetrieveMotocicleObjectIsError_ThenShowError() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .motocicle
        
        motocicleService.responseHandler = .failure({
            NSError(domain:"Data does't exist", code: 500, userInfo:nil)
        })
        
        // Act
        sut.searchVehicle(numberPlaque: "ASF890")
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.showError)
        } else {
            XCTFail("Delay interrupted")
        }
    }
}
