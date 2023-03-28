//
//  ExitMotorcycleServiceTest.swift
//  ADNParqueaderoTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 28/03/23.
//

import Combine
@testable import Domain
@testable import Infraestructure

final class ExitMotorcycleServiceStub: ExitMotorcycleServiceProtocol {
    
    enum InteractorStubCase<T> {
        case success(() -> T)
        case failure(() -> Error)
    }
    
    private var exitMotorcycle: Domain.ExitMotorcycle?
    var responseHandler: InteractorStubCase<Any>
    
    init(exitMotorcycle: Domain.ExitMotorcycle?) {
        self.exitMotorcycle = exitMotorcycle
        responseHandler = .failure({
            CostumErrors.errorCoreData
        })
    }
    
    func retrieveMotocycle(numerPlaque: String) -> AnyPublisher<Domain.ExitMotorcycle?, Error> {
        var publisher = CurrentValueSubject<Domain.ExitMotorcycle?, Error>(exitMotorcycle)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<Domain.ExitMotorcycle?, Error>(exitMotorcycle)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func deleteMotorcycle(numerPlaque: String) -> AnyPublisher<Bool, Error> {
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
