//
//  RegisterCarServiceTest.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 27/03/23.
//

import Combine
import XCTest
@testable import Domain

final class RegisterCarServiceTest: XCTestCase {

    private var sut: RegisterCarService!
    private var registerCarRepository: ResgisterCarRepositoryStub!
    private var cancellable: AnyCancellable?
    
    override func setUpWithError() throws {
        registerCarRepository = ResgisterCarRepositoryStub()
        sut = RegisterCarService(registerCarRepository: registerCarRepository)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        ResgisterCarRepositoryStub.error = nil
        ResgisterCarRepositoryStub.responseDataExist = true
        ResgisterCarRepositoryStub.numberCarsStored = 2
        registerCarRepository = nil
        sut = nil
        try super.tearDownWithError()
    }

    func test_saveCar_ThenIsSuccess() {
        // Arrange
        let successExpectation = expectation(description: "Success save")
        let failureExpectation = expectation(description: "Error save")
        failureExpectation.isInverted = true
        ResgisterCarRepositoryStub.responseDataExist = false
        
        // Act
        cancellable = sut.saveCar(with: DomainTestMock.registerVehicleCarMock)
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
                failureExpectation.fulfill()
            }, receiveValue: { response in
                // Assert
                XCTAssertTrue(response)
                successExpectation.fulfill()
            })
        
        wait(for: [successExpectation, failureExpectation], timeout: 0.5)
        cancellable?.cancel()
    }
    
    func test_saveCar_WhenRegisterExist_ThenIsError() {
        // Arrange
        let successExpectation = expectation(description: "Success save")
        let failureExpectation = expectation(description: "Error save")
        successExpectation.isInverted = true
        
        // Act
        cancellable = sut.saveCar(with: DomainTestMock.registerVehicleCarMock)
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                
                // Assert
                XCTAssertNotNil(error)
                failureExpectation.fulfill()
            }, receiveValue: { response in
                XCTFail("Delay interrupted")
                successExpectation.fulfill()
            })
        
        wait(for: [successExpectation, failureExpectation], timeout: 0.5)
        cancellable?.cancel()
    }
    
    func test_saveCar_WhenRegisterVehiculeForCarIsFull_ThenIsError() {
        // Arrange
        let successExpectation = expectation(description: "Success save")
        let failureExpectation = expectation(description: "Error save")
        successExpectation.isInverted = true
        ResgisterCarRepositoryStub.numberCarsStored = 20
        
        
        // Act
        cancellable = sut.saveCar(with: DomainTestMock.registerVehicleCarMock)
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                
                // Assert
                XCTAssertNotNil(error)
                failureExpectation.fulfill()
            }, receiveValue: { response in
                XCTFail("Delay interrupted")
                successExpectation.fulfill()
            })
        
        wait(for: [successExpectation, failureExpectation], timeout: 0.5)
        cancellable?.cancel()
    }
    
    func test_saveCar_ThenFailure() {
        // Arrange
        var response: Error?
        let successExpectation = expectation(description: "Success save")
        let failureExpectation = expectation(description: "Error save")
        successExpectation.isInverted = true
        ResgisterCarRepositoryStub.error = DomainTestMock.errorMock
        
        // Act
        cancellable = sut.saveCar(with: DomainTestMock.registerVehicleCarMock)
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                response = error
                // Assert
                
                XCTAssertNotNil(response)
                failureExpectation.fulfill()
            }, receiveValue: { response in
                XCTFail("Delay interrupted")
                successExpectation.fulfill()
            })
        
        wait(for: [successExpectation, failureExpectation], timeout: 0.5)
        cancellable?.cancel()
    }
    
    func test_retrieveNumberCars_ThenIsSuccess() {
        // Arrange
        let successExpectation = expectation(description: "Success retrieve")
        let failureExpectation = expectation(description: "Error retrieve")
        failureExpectation.isInverted = true
        
        // Act
        cancellable = sut.retrieveNumberCars()
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
                failureExpectation.fulfill()
            }, receiveValue: { response in
                // Assert
                XCTAssertEqual(response, 2)
                successExpectation.fulfill()
            })
        
        wait(for: [successExpectation, failureExpectation], timeout: 0.5)
        cancellable?.cancel()
    }
    
    func test_retrieveNumberCars_ThenFailure() {
        // Arrange
        var response: Error?
        let successExpectation = expectation(description: "Success retrieve")
        let failureExpectation = expectation(description: "Error retrieve")
        successExpectation.isInverted = true
        ResgisterCarRepositoryStub.error = DomainTestMock.errorMock
        
        // Act
        cancellable = sut.retrieveNumberCars()
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                response = error
                // Assert
                
                XCTAssertNotNil(response)
                failureExpectation.fulfill()
            }, receiveValue: { response in
                XCTFail("Delay interrupted")
                successExpectation.fulfill()
            })
        
        wait(for: [successExpectation, failureExpectation], timeout: 0.5)
        cancellable?.cancel()
    }
}
