//
//  CarServiceTest.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 27/03/23.
//

import Combine
import XCTest
@testable import Domain

final class CarServiceTest: XCTestCase {

    private var sut: CarService!
    private var carRepository: CarRepositoryStub!
    private var cancellable: AnyCancellable?
    
    override func setUpWithError() throws {
        carRepository = CarRepositoryStub()
        sut = CarService(carRepository: carRepository)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        CarRepositoryStub.error = nil
        carRepository = nil
        sut = nil
        try super.tearDownWithError()
    }

    func test_saveCar_ThenIsSuccess() {
        // Arrange
        let successExpectation = expectation(description: "Success save")
        let failureExpectation = expectation(description: "Error save")
        failureExpectation.isInverted = true
        
        // Act
        cancellable = sut.saveCar(with: DomainTestMock.registerCarMock)
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
    
    func test_saveCar_ThenFailure() {
        // Arrange
        var response: Error?
        let successExpectation = expectation(description: "Success save")
        let failureExpectation = expectation(description: "Error save")
        successExpectation.isInverted = true
        CarRepositoryStub.error = DomainTestMock.errorMock
        
        // Act
        cancellable = sut.saveCar(with: DomainTestMock.registerCarMock)
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
    
    func test_retrieveCarObjects_ThenIsSuccess() {
        // Arrange
        let successExpectation = expectation(description: "Success retrieve")
        let failureExpectation = expectation(description: "Error retrieve")
        failureExpectation.isInverted = true
        
        // Act
        cancellable = sut.retrieveCarObjects()
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
    
    func test_retrieveCarObjects_ThenFailure() {
        // Arrange
        var response: Error?
        let successExpectation = expectation(description: "Success retrieve")
        let failureExpectation = expectation(description: "Error retrieve")
        successExpectation.isInverted = true
        CarRepositoryStub.error = DomainTestMock.errorMock
        
        // Act
        cancellable = sut.retrieveCarObjects()
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
    
    func test_retrieveCarObject_ThenIsSuccess() {
        // Arrange
        let successExpectation = expectation(description: "Success retrieve")
        let failureExpectation = expectation(description: "Error retrieve")
        failureExpectation.isInverted = true
        
        // Act
        cancellable = sut.retrieveCarObject(numerPlaque: "ASR789")
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
                failureExpectation.fulfill()
            }, receiveValue: { response in
                
                // Assert
                XCTAssertEqual(response?.getHoursAndDaysOfParking().hours, 2)
                successExpectation.fulfill()
            })
        
        wait(for: [successExpectation, failureExpectation], timeout: 0.5)
        cancellable?.cancel()
    }
    
    func test_retrieveCarObject_ThenFailure() {
        // Arrange
        var response: Error?
        let successExpectation = expectation(description: "Success retrieve")
        let failureExpectation = expectation(description: "Error retrieve")
        successExpectation.isInverted = true
        CarRepositoryStub.error = DomainTestMock.errorMock
        
        // Act
        cancellable = sut.retrieveCarObject(numerPlaque: "ASR789")
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
    
    func test_deleteCar_ThenIsSuccess() {
        // Arrange
        let successExpectation = expectation(description: "Success retrieve")
        let failureExpectation = expectation(description: "Error retrieve")
        failureExpectation.isInverted = true
        
        // Act
        cancellable = sut.deleteCar(numerPlaque: "ASR789")
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
    
    func test_deleteCar_ThenFailure() {
        // Arrange
        var response: Error?
        let successExpectation = expectation(description: "Success retrieve")
        let failureExpectation = expectation(description: "Error retrieve")
        successExpectation.isInverted = true
        CarRepositoryStub.error = DomainTestMock.errorMock
        
        // Act
        cancellable = sut.deleteCar(numerPlaque: "ASR789")
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
