//
//  ExitVehicleViewModelTest.swift
//  ADNParqueaderoTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//

import XCTest
@testable import Infraestructure
@testable import Domain
@testable import ADNParqueadero

final class ExitVehicleViewModelTest: XCTestCase {
    private var sut: ExitVehicleViewModel!
    private var exitVehicleService: ExitVehicleServiceStub!
    
    override func setUpWithError() throws {
        exitVehicleService = ExitVehicleServiceStub(exitCar: ConstantsMock.exitCarMock)
        sut = ExitVehicleViewModel(exitVehicleService: exitVehicleService)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        exitVehicleService = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_searchVehicle_WhenRetrieveCarObjectIsSuccess_ThenShowValue() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .car
        sut.state.inputNumberPlaque = "ASF890"
        
        exitVehicleService.responseHandler = .success {
            ConstantsMock.registerVehiclesWithCarMock
        }
         
        // Act
        sut.searchVehicle()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.valueToPay, 2000)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_searchCar_WhenRetrieveCarIsError_ThenShowError() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .car
        sut.state.inputNumberPlaque = "ASF890"
        
        exitVehicleService.responseHandler = .failure({
            NSError(domain:"Data does't exist", code: 500, userInfo:nil)
        })
        
        // Act
        sut.searchVehicle()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.showError)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_searchVehicle_WhenRetrieveMotocicleIsSuccess_ThenShowValue() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .motocicle
        sut.state.inputNumberPlaque = "THD785"
        
        exitVehicleService = ExitVehicleServiceStub(exitCar: ConstantsMock.exitMotorcycle)
        sut = ExitVehicleViewModel(exitVehicleService: exitVehicleService)
        
        exitVehicleService.responseHandler = .success {
            ConstantsMock.registerVehiclesWithMotorcycles
        }
        
        // Act
        sut.searchVehicle()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.valueToPay, 1000)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_searchVehicle_WhenRetrieveMotocicleWith600CCIsSuccess_ThenShowValue() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .motocicle
        sut.state.inputNumberPlaque = "THD785"
        let motorcycle = ExitMotorcycle(plaqueId: "FHD785",
                                             registerDay: ConstantsMock.getDateMock(),
                                             exitDate: Date(),
                                             cylinderCapacity: "600")
        
        exitVehicleService = ExitVehicleServiceStub(exitCar: motorcycle)
        sut = ExitVehicleViewModel(exitVehicleService: exitVehicleService)
        
        exitVehicleService.responseHandler = .success {
            ConstantsMock.registerVehiclesWithMotorcycles
        }
        
        // Act
        sut.searchVehicle()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.valueToPay, 3000)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_searchVehicle_WhenIsMotorcycleRetrieveMotocicleObjectIsError_ThenShowError() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .motocicle
        sut.state.inputNumberPlaque = "ASF890"
        
        exitVehicleService.responseHandler = .failure({
            NSError(domain:"Data does't exist", code: 500, userInfo:nil)
        })
        
        // Act
        sut.searchVehicle()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.showError)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
     func test_paymentVehicle_WhenIsMotorcycleDBResponseSuccess_ThenResetData() {
        // Arrange
        let expectation = XCTestExpectation(description: "Reset state")
        sut.state.seletedVehicleType = .motocicle
        sut.state.inputNumberPlaque = "THD785"
        sut.state.hoursToPay = 2
        
         exitVehicleService.responseHandler = .success {
            ConstantsMock.registerVehiclesWithMotorcycles
        }
        
        // Act
        sut.paymentVehicle()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.hoursToPay, 0)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_paymentVehicle_WhenIsMotorcycleDBResponseError_ThenDoesnotResetData() {
       // Arrange
       let expectation = XCTestExpectation(description: "Does not reset state")
       sut.state.seletedVehicleType = .motocicle
       sut.state.inputNumberPlaque = "THD785"
       sut.state.hoursToPay = 2
       
        exitVehicleService.responseHandler = .failure {
           NSError(domain:"Data does't exist", code: 500, userInfo:nil)
       }
       
       // Act
       sut.paymentVehicle()
       
       // Assert
       let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
       if result == XCTWaiter.Result.timedOut {
           XCTAssertTrue(!sut.state.inputNumberPlaque.isEmpty)
       } else {
           XCTFail("Delay interrupted")
       }
   }
    
    func test_paymentVehicle_WhenDBResponseSuccess_ThenResetData() {
       // Arrange
       let expectation = XCTestExpectation(description: "Reset state")
       sut.state.seletedVehicleType = .motocicle
       sut.state.inputNumberPlaque = "BHD985"
       sut.state.hoursToPay = 1
       
        exitVehicleService.responseHandler = .success {
           ConstantsMock.registerVehiclesWithCarMock
       }
       
       // Act
       sut.paymentVehicle()
       
       // Assert
       let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
       if result == XCTWaiter.Result.timedOut {
           XCTAssertEqual(sut.state.hoursToPay, 0)
       } else {
           XCTFail("Delay interrupted")
       }
   }
    
    func test_paymentVehicle_WhenDBResponseError_ThenResetData() {
       // Arrange
       let expectation = XCTestExpectation(description: "Does not reset state")
       sut.state.seletedVehicleType = .motocicle
       sut.state.inputNumberPlaque = "BHD985"
       sut.state.hoursToPay = 1
       
        exitVehicleService.responseHandler = .failure {
           NSError(domain:"Data does't exist", code: 500, userInfo:nil)
       }
       
       // Act
       sut.paymentVehicle()
       
       // Assert
       let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
       if result == XCTWaiter.Result.timedOut {
           XCTAssertTrue(!sut.state.inputNumberPlaque.isEmpty)
       } else {
           XCTFail("Delay interrupted")
       }
   }
}
