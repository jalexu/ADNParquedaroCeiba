//
//  ExitVehicleRepositoryRealmTest.swift
//  InfraestructureTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 5/04/23.
//

import XCTest
import Combine
@testable import Infraestructure

final class ExitVehicleRepositoryRealmTest: XCTestCase {
    private var sut: ExitVehicleRepositoryRealm!
    private var realmManagerStub: RealmManagerStub!
    private var cancellable: AnyCancellable?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        realmManagerStub = RealmManagerStub()
        sut = ExitVehicleRepositoryRealm(realmManager: realmManagerStub)
    }

    override func tearDownWithError() throws {
        sut = nil
        realmManagerStub = nil
        cancellable = nil
        try super.tearDownWithError()
    }
    
    func test_deleteRegister_WhenIsACar_IsSuccess() {
        // Arrange
        let successExpectation = expectation(description: "Save is success")
        let failureExpectation = expectation(description: "Error save")
        failureExpectation.isInverted = true
        
        // Act
        cancellable = sut.deleteRegister(numerPlaque: "SDL678")
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
                failureExpectation.fulfill()
            }, receiveValue: { wasDeleted in
                // Assert
                XCTAssertTrue(wasDeleted)
                successExpectation.fulfill()
            })
        
        wait(for: [successExpectation, failureExpectation], timeout: 0.5)
        cancellable?.cancel()
    }
    
    func test_deleteRegister_WhenIsAMotorcycle_IsSuccess() {
        // Arrange
        let successExpectation = expectation(description: "Save is success")
        let failureExpectation = expectation(description: "Error save")
        failureExpectation.isInverted = true
        realmManagerStub.isCar = false
        
        // Act
        cancellable = sut.deleteRegister(numerPlaque: "SDL678")
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
                failureExpectation.fulfill()
            }, receiveValue: { wasDeleted in
                // Assert
                XCTAssertTrue(wasDeleted)
                successExpectation.fulfill()
            })
        
        wait(for: [successExpectation, failureExpectation], timeout: 0.5)
        cancellable?.cancel()
    }
    
    func test_retrieveExitVehicle_WhenIsACar_ThenIsSucess() {
        // Arrange
        let successExpectation = expectation(description: "Save success")
        let failureExpectation = expectation(description: "Error save")
        failureExpectation.isInverted = true
        
        // Act
        cancellable = sut.retrieveExitVehicle(numerPlaque: "1234")
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
                failureExpectation.fulfill()
            }, receiveValue: { exitVehicle in
                // Assert
                XCTAssertEqual(exitVehicle?.totalToPay(), 1000)
                successExpectation.fulfill()
            })
        
        wait(for: [successExpectation, failureExpectation], timeout: 0.5)
        cancellable?.cancel()
    }
    
    func test_retrieveExitVehicle_WhenIsAMotorcycle_ThenIsSucess() {
        // Arrange
        let successExpectation = expectation(description: "Save success")
        let failureExpectation = expectation(description: "Error save")
        failureExpectation.isInverted = true
        realmManagerStub.isCar = false
        
        // Act
        cancellable = sut.retrieveExitVehicle(numerPlaque: "1234")
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
                failureExpectation.fulfill()
            }, receiveValue: { exitVehicle in
                // Assert
                XCTAssertEqual(exitVehicle?.totalToPay(), 500)
                successExpectation.fulfill()
            })
        
        wait(for: [successExpectation, failureExpectation], timeout: 0.5)
        cancellable?.cancel()
    }
    
    func test_retrieveExitVehicle_WhenIsNil_ThenReturnNil() {
        // Arrange
        let successExpectation = expectation(description: "Save success")
        let failureExpectation = expectation(description: "Error save")
        failureExpectation.isInverted = true
        realmManagerStub.isCar = false
        
        // Act
        cancellable = sut.retrieveExitVehicle(numerPlaque: "1234")
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
                failureExpectation.fulfill()
            }, receiveValue: { exitVehicle in
                // Assert
                XCTAssertEqual(exitVehicle?.totalToPay(), 500)
                successExpectation.fulfill()
            })
        
        wait(for: [successExpectation, failureExpectation], timeout: 0.5)
        cancellable?.cancel()
    }

}
