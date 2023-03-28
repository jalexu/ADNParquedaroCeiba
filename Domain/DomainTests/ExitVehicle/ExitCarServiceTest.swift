//
//  ExitCarServiceTest.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 28/03/23.
//

import Combine
import XCTest
@testable import Domain

final class ExitCarServiceTest: XCTestCase {

    private var sut: ExitCarService!
    private var exitCarRepository: ExitCarRepositoryStub!
    private var cancellable: AnyCancellable?
    
    override func setUpWithError() throws {
        exitCarRepository = ExitCarRepositoryStub()
        sut = ExitCarService(exitCarRepository: exitCarRepository)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        ExitCarRepositoryStub.error = nil
        exitCarRepository = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    
    func test_retrieveCar_ThenIsSuccess() {
        // Arrange
        let successExpectation = expectation(description: "Success retrieve")
        let failureExpectation = expectation(description: "Error retrieve")
        failureExpectation.isInverted = true
        
        // Act
        cancellable = sut.retrieveExitCar(numerPlaque: "ASR789")
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
    
    func test_retrieveCar_ThenFailure() {
        // Arrange
        var response: Error?
        let successExpectation = expectation(description: "Success retrieve")
        let failureExpectation = expectation(description: "Error retrieve")
        successExpectation.isInverted = true
        ExitCarRepositoryStub.error = DomainTestMock.errorMock
        
        // Act
        cancellable = sut.retrieveExitCar(numerPlaque: "ASR789")
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
        ExitCarRepositoryStub.error = DomainTestMock.errorMock
        
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
