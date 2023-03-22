//
//  CoreDataRepositoryStub.swift
//  ADNParqueaderoTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 22/03/23.
//

import Combine
@testable import Domain
@testable import Infraestructure

final class CoreDataRepositoryStub: CoreDataRepositoryProtocol {
    
    enum InteractorStubCase<T> {
        case success(() -> T)
        case failure(() -> Error)
    }
    
    private var vehicleObjects:[Domain.Vehicle] = []
    var responseHandler: InteractorStubCase<Any>
    
    init(vehicleObjects: [Domain.Vehicle] ) {
        self.vehicleObjects = vehicleObjects
        responseHandler = .failure({
            CostumErrors.errorCoreData
        })
    }
    
    func save(with data: Domain.Vehicle) -> AnyPublisher<Bool, Error> {
        var publisher = CurrentValueSubject<Bool, Error>(true)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<Bool, Error>(true)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func retrieveObjects() -> AnyPublisher<[Domain.Vehicle], Error> {
        var publisher = CurrentValueSubject<[Domain.Vehicle], Error>(vehicleObjects)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<[Domain.Vehicle], Error>(vehicleObjects)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func retrieveObject(numerPlaque: String) -> AnyPublisher<Domain.Vehicle?, Error> {
        var publisher = CurrentValueSubject<Domain.Vehicle?, Error>(vehicleObjects.first)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<Domain.Vehicle?, Error>(vehicleObjects.first)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func delete(numerPlaque: String) -> AnyPublisher<Bool, Error> {
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
