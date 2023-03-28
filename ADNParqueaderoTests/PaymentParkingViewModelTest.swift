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
    private var exitCarService: ExitCarServiceStub!
    private var exitMotorcycleService: ExitMotorcycleServiceStub!
    
    override func setUpWithError() throws {
        exitCarService = ExitCarServiceStub(exitCar: ConstantsMock.exitCarMock)
        exitMotorcycleService = ExitMotorcycleServiceStub(exitMotorcycle: ConstantsMock.exitMotorcycle)
        sut = PaymentParkingViewModel(carService: exitCarService, motocicleService: exitMotorcycleService)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        exitCarService = nil
        exitMotorcycleService = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_searchCar_WhenRetrieveCarObjectIsSuccess_ThenShowValue() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .car
        sut.state.inputNumberPlaque = "ASF890"
        
        exitCarService.responseHandler = .success {
            ConstantsMock.registerVehiclesWithCarMock
        }
         
        // Act
        sut.searchCar()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.valueToPay, 2000)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_searchCar_WhenRetrieveCarObjectIsError_ThenShowError() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .car
        sut.state.inputNumberPlaque = "ASF890"
        
        exitCarService.responseHandler = .failure({
            NSError(domain:"Data does't exist", code: 500, userInfo:nil)
        })
        
        // Act
        sut.searchCar()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.showError)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_searchMotocicle_WhenRetrieveMotocicleObjectIsSuccess_ThenShowValue() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .motocicle
        sut.state.inputNumberPlaque = "THD785"
        
        exitMotorcycleService.responseHandler = .success {
            ConstantsMock.registerVehiclesWithMotorcycles
        }
        
        // Act
        sut.searchMotocicle()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.valueToPay, 1000)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_searchMotocicle_WhenRetrieveMotocicleWith600CCIsSuccess_ThenShowValue() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .motocicle
        sut.state.inputNumberPlaque = "THD785"
        let motorcycle = ExitMotorcycle(plaqueId: "FHD785",
                                             registerDay: ConstantsMock.getDateMock(),
                                             exitDate: Date(),
                                             cylinderCapacity: "600")
        
        exitMotorcycleService = ExitMotorcycleServiceStub(exitMotorcycle: motorcycle)
        sut = PaymentParkingViewModel(carService: exitCarService, motocicleService: exitMotorcycleService)
        
        exitMotorcycleService.responseHandler = .success {
            ConstantsMock.registerVehiclesWithMotorcycles
        }
        
        // Act
        sut.searchMotocicle()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.valueToPay, 3000)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_searchMotocicle_WhenRetrieveMotocicleObjectIsError_ThenShowError() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .motocicle
        sut.state.inputNumberPlaque = "ASF890"
        
        exitMotorcycleService.responseHandler = .failure({
            NSError(domain:"Data does't exist", code: 500, userInfo:nil)
        })
        
        // Act
        sut.searchMotocicle()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.showError)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
     func test_paymentMotocicle_WhenDBResponseSuccess_ThenResetData() {
        // Arrange
        let expectation = XCTestExpectation(description: "Reset state")
        sut.state.seletedVehicleType = .motocicle
        sut.state.inputNumberPlaque = "THD785"
        sut.state.hoursToPay = 2
        
        exitMotorcycleService.responseHandler = .success {
            ConstantsMock.registerVehiclesWithMotorcycles
        }
        
        // Act
        sut.paymentMotocicle()
        
        // Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.state.hoursToPay, 0)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_paymentMotocicle_WhenDBResponseError_ThenDoesnotResetData() {
       // Arrange
       let expectation = XCTestExpectation(description: "Does not reset state")
       sut.state.seletedVehicleType = .motocicle
       sut.state.inputNumberPlaque = "THD785"
       sut.state.hoursToPay = 2
       
       exitMotorcycleService.responseHandler = .failure {
           NSError(domain:"Data does't exist", code: 500, userInfo:nil)
       }
       
       // Act
       sut.paymentMotocicle()
       
       // Assert
       let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
       if result == XCTWaiter.Result.timedOut {
           XCTAssertTrue(!sut.state.inputNumberPlaque.isEmpty)
       } else {
           XCTFail("Delay interrupted")
       }
   }
    
    func test_paymentCar_WhenDBResponseSuccess_ThenResetData() {
       // Arrange
       let expectation = XCTestExpectation(description: "Reset state")
       sut.state.seletedVehicleType = .motocicle
       sut.state.inputNumberPlaque = "BHD985"
       sut.state.hoursToPay = 1
       
       exitCarService.responseHandler = .success {
           ConstantsMock.registerVehiclesWithCarMock
       }
       
       // Act
       sut.paymentCar()
       
       // Assert
       let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
       if result == XCTWaiter.Result.timedOut {
           XCTAssertEqual(sut.state.hoursToPay, 0)
       } else {
           XCTFail("Delay interrupted")
       }
   }
    
    func test_paymentCar_WhenDBResponseError_ThenResetData() {
       // Arrange
       let expectation = XCTestExpectation(description: "Does not reset state")
       sut.state.seletedVehicleType = .motocicle
       sut.state.inputNumberPlaque = "BHD985"
       sut.state.hoursToPay = 1
       
       exitCarService.responseHandler = .failure {
           NSError(domain:"Data does't exist", code: 500, userInfo:nil)
       }
       
       // Act
       sut.paymentCar()
       
       // Assert
       let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
       if result == XCTWaiter.Result.timedOut {
           XCTAssertTrue(!sut.state.inputNumberPlaque.isEmpty)
       } else {
           XCTFail("Delay interrupted")
       }
   }
}
