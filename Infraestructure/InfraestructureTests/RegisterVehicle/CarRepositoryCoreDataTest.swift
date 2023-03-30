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
import CoreData

final class CarRepositoryCoreDataTest: XCTestCase {
    
    private var sut: RegisterVehicleRepository!
    private var cancellable: AnyCancellable?
    private var coreDataStack: TestCoreDataStack!
    
    override func setUpWithError() throws {
        coreDataStack = TestCoreDataStack()
        ConfigurationCoreDataBase.contexts = coreDataStack.mainContext
        sut = RegisterVehicleRepositoryCoreData()
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
        cancellable = sut.save(with: registerVehicle)
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
        
        cancellable = sut.save(with: registerVehicle)
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
            }, receiveValue: { _ in })
        
        
        // Act
        cancellable = sut.retrieveAll()
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
                failureExpectation.fulfill()
            }, receiveValue: { response in
                // Assert
                XCTAssertEqual(response.count, 1)
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


class TestCoreDataStack  {
    static let shared = TestCoreDataStack()
    let persistentContainer: NSPersistentContainer
    let backgroundContext: NSManagedObjectContext
    let mainContext: NSManagedObjectContext
    let objectModel: NSManagedObjectModel
    
    init () {
        let messageKitBundle = Bundle(identifier: "com.jaime.uribe.Infraestructure")
        guard let modelURL = messageKitBundle!.url(forResource: "RegisterVehiclesDB" , withExtension: "momd")else {
            preconditionFailure("No found database")
        }
        
        objectModel = NSManagedObjectModel(contentsOf: modelURL)!
        persistentContainer = NSPersistentContainer(name: "RegisterVehiclesDB", managedObjectModel: objectModel)
        let descripcion = persistentContainer.persistentStoreDescriptions.first
        descripcion?.type = NSInMemoryStoreType
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        mainContext = persistentContainer.viewContext
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundContext.parent = self.mainContext
        
    }
}
 
