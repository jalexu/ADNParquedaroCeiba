//
//  CarServiceStub.swift
//  ADNParqueaderoTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 22/03/23.
//

import Combine
@testable import Domain
@testable import Infraestructure

final class CarServiceStub: CarServiceProtocol {
    enum InteractorStubCase<T> {
        case success(() -> T)
        case failure(() -> Error)
    }
    
    private var vehicleObjects: [Domain.RegisterCar] = []
    var exitCarObject: ExitCar?
    var responseHandler: InteractorStubCase<Any>
    
    init(vehicleObjects: [Domain.RegisterCar] ) {
        self.vehicleObjects = vehicleObjects
        responseHandler = .failure({
            CostumErrors.errorCoreData
        })
    }
    
    func saveCar(with data: Domain.RegisterCar) -> AnyPublisher<Bool, Error> {
        var publisher = CurrentValueSubject<Bool, Error>(true)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<Bool, Error>(true)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func retrieveCarObjects() -> AnyPublisher<Int, Error> {
        var publisher = CurrentValueSubject<Int, Error>(vehicleObjects.count)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<Int, Error>(vehicleObjects.count)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func retrieveCarObject(numerPlaque: String) -> AnyPublisher<Domain.ExitCar?, Error> {
        var publisher = CurrentValueSubject<Domain.ExitCar?, Error>(exitCarObject)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<Domain.ExitCar?, Error>(exitCarObject)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func deleteCar(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        var publisher = CurrentValueSubject<Bool, Error>(true)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<Bool, Error>(true)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
