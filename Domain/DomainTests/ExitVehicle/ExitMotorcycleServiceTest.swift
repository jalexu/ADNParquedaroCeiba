//
//  ExitMotorcycleServiceTest.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 28/03/23.
//

import XCTest
import Combine
@testable import Domain

final class ExitMotorcycleServiceTest: XCTestCase {
    private var sut: ExitMotorcycleService!
    private var exitMotorcycleRepository: ExitMotorcycleRepositoryStub!
    private var cancellable: AnyCancellable?
    
    override func setUpWithError() throws {
        exitMotorcycleRepository = ExitMotorcycleRepositoryStub()
        sut = ExitMotorcycleService(exitMotocicleRepository: exitMotorcycleRepository)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        ExitMotorcycleRepositoryStub.error = nil
        exitMotorcycleRepository = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    
    func test_retrieveMotocycle_ThenIsSuccess() {
        // Arrange
        let successExpectation = expectation(description: "Success retrieve")
        let failureExpectation = expectation(description: "Error retrieve")
        failureExpectation.isInverted = true
        
        // Act
        cancellable = sut.retrieveMotocycle(numerPlaque: "ASR789")
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
    
    func test_retrieveMotocycle_ThenFailure() {
        // Arrange
        var response: Error?
        let successExpectation = expectation(description: "Success retrieve")
        let failureExpectation = expectation(description: "Error retrieve")
        successExpectation.isInverted = true
        ExitMotorcycleRepositoryStub.error = DomainTestMock.errorMock
        
        // Act
        cancellable = sut.retrieveMotocycle(numerPlaque: "ASR789")
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
    
    func test_deleteMotorcycle_ThenIsSuccess() {
        // Arrange
        let successExpectation = expectation(description: "Success retrieve")
        let failureExpectation = expectation(description: "Error retrieve")
        failureExpectation.isInverted = true
        
        // Act
        cancellable = sut.deleteMotorcycle(numerPlaque: "ASR789")
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
    
    func test_deleteMotorcycle_ThenFailure() {
        // Arrange
        var response: Error?
        let successExpectation = expectation(description: "Success retrieve")
        let failureExpectation = expectation(description: "Error retrieve")
        successExpectation.isInverted = true
        ExitMotorcycleRepositoryStub.error = DomainTestMock.errorMock
        
        // Act
        cancellable = sut.deleteMotorcycle(numerPlaque: "ASR789")
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
