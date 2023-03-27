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
    
    func test_searchCar_WhenRetrieveCarObjectIsSuccess_ThenShowValue() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .car
        sut.state.inputNumberPlaque = "ASF890"
        
        carService.responseHandler = .success {
            ConstantsMock.registerCars
        }
        
        carService.exitCarObject = ExitCar(plaqueId: "ASF890",
                                           registerDay: ConstantsMock.getDateMock(),
                                           exitDate: Date())
         
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
        
        carService.responseHandler = .failure({
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
        
        motocicleService.responseHandler = .success {
            ConstantsMock.registerMotocicles
        }
        
        motocicleService.exitMotocicleObject = .init(
            plaqueId: "THD785",
            registerDay: ConstantsMock.getDateMock(),
            exitDate: Date(),
            cylinderCapacity: "200")
        
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
    
    func test_searchMotocicle_WhenRetrieveMotocicleObjectWith600CCIsSuccess_ThenShowValue() {
        // Arrange
        let expectation = XCTestExpectation(description: "Show value to pay")
        sut.state.seletedVehicleType = .motocicle
        sut.state.inputNumberPlaque = "THD785"
        
        motocicleService.responseHandler = .success {
            ConstantsMock.registerMotocicles
        }
        
        motocicleService.exitMotocicleObject = .init(
            plaqueId: "FHD785",
            registerDay: ConstantsMock.getDateMock(),
            exitDate: Date(),
            cylinderCapacity: "600")
        
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
        
        motocicleService.responseHandler = .failure({
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
        
        motocicleService.responseHandler = .success {
            ConstantsMock.registerMotocicles
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
       
       motocicleService.responseHandler = .failure {
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
       
       carService.responseHandler = .success {
           ConstantsMock.registerCars
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
       
       carService.responseHandler = .failure {
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
