//
//  MotocicleServiceStub.swift
//  ADNParqueaderoTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 25/03/23.
//

import Combine
@testable import Domain
@testable import Infraestructure

final class MotocicleServiceStub: MotocicleServiceProtocol {

    enum InteractorStubCase<T> {
        case success(() -> T)
        case failure(() -> Error)
    }
    
    private var vehicleObjects: [Domain.RegisterMotocicle] = []
    var exitMotocicleObject: Domain.ExitMotocicle?
    var responseHandler: InteractorStubCase<Any>
    
    init(vehicleObjects: [Domain.RegisterMotocicle] ) {
        self.vehicleObjects = vehicleObjects
        responseHandler = .failure({
            CostumErrors.errorCoreData
        })
    }
    
    func save(with data: Domain.RegisterMotocicle) -> AnyPublisher<Bool, Error> {
        var publisher = CurrentValueSubject<Bool, Error>(true)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<Bool, Error>(true)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func retrieveObjects() -> AnyPublisher<Int, Error> {
        var publisher = CurrentValueSubject<Int, Error>(vehicleObjects.count)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<Int, Error>(vehicleObjects.count)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func retrieveObject(numerPlaque: String) -> AnyPublisher<Domain.ExitMotocicle?, Error> {
        var publisher = CurrentValueSubject<Domain.ExitMotocicle?, Error>(exitMotocicleObject)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<Domain.ExitMotocicle?, Error>(exitMotocicleObject)
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
