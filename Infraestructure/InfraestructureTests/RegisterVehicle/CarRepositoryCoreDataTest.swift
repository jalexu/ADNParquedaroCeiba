//
//  CarRepositoryCoreDataTest.swift
//  InfraestructureTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 29/03/23.
//

import Combine
import XCTest
@testable import Domain
@testable import Infraestructure

/*
 final class CarRepositoryCoreDataTest: XCTestCase {
 
 private var sut: RegisterCarRepository!
 private var cancellable: AnyCancellable?
 
 override func setUpWithError() throws {
 sut = CarRepositoryCoreData()
 try super.setUpWithError()
 }
 
 override func tearDownWithError() throws {
 sut = nil
 try super.tearDownWithError()
 }
 
 
 func test_saveCar_ThenIsSuccess() throws {
 // Arrange
 let successExpectation = expectation(description: "Success save")
 let failureExpectation = expectation(description: "Error save")
 failureExpectation.isInverted = true
 
 let car = try Car(plaqueId: "YUD890")
 let registerVehicle = try RegisterVehicle(vehicle: car,
 registerDay: getRegisterDayMock())
 
 // Act
 cancellable = sut.saveCar(with: registerVehicle)
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
 
 func test_retrieveNumberCars_ThenIsSuccess() throws {
 // Arrange
 let successExpectation = expectation(description: "Retrieve Success")
 let failureExpectation = expectation(description: "Error save")
 failureExpectation.isInverted = true
 
 let car = try Car(plaqueId: "YUD890")
 let registerVehicle = try RegisterVehicle(vehicle: car,
 registerDay: getRegisterDayMock())
 
 // Act
 cancellable = sut.saveCar(with: registerVehicle)
 .sink(receiveCompletion: { completion in
 guard case .failure(let error) = completion else { return }
 XCTFail(error.localizedDescription)
 failureExpectation.fulfill()
 }, receiveValue: { response in
 // Assert
 XCTAssertTrue(response)
 successExpectation.fulfill()
 })
 
 // Act
 cancellable = sut.retrieveNumberCars()
 .sink(receiveCompletion: { completion in
 guard case .failure(let error) = completion else { return }
 XCTFail(error.localizedDescription)
 failureExpectation.fulfill()
 }, receiveValue: { response in
 // Assert
 XCTAssertEqual(response, 1)
 successExpectation.fulfill()
 })
 
 wait(for: [successExpectation, failureExpectation], timeout: 0.5)
 cancellable?.cancel()
 }
 
 
 
 func getRegisterDayMock() -> Date {
 let today: Date = Date()
 return today.addingTimeInterval(-7200)
 }
 
 func resetDabase() {
 
 }
 
 }
 */
