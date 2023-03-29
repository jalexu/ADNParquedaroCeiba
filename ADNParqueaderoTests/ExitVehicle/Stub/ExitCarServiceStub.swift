//
//  ExitCarServiceStub.swift
//  ADNParqueaderoTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 28/03/23.
//

import Combine
@testable import Domain
@testable import Infraestructure

final class ExitCarServiceStub: ExitCarServiceProtocol {
    enum InteractorStubCase<T> {
        case success(() -> T)
        case failure(() -> Error)
    }
    
    private var exitCar: ExitCar?
    var responseHandler: InteractorStubCase<Any>
    
    init(exitCar: ExitCar?) {
        self.exitCar = exitCar
        responseHandler = .failure({
            CostumErrors.errorCoreData
        })
    }
    
    func retrieveExitCar(numerPlaque: String) -> AnyPublisher<Domain.ExitCar?, Error> {
        var publisher = CurrentValueSubject<Domain.ExitCar?, Error>(exitCar)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<Domain.ExitCar?, Error>(exitCar)
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
