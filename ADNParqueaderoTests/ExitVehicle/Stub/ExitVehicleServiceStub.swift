//
//  ExitVehicleServiceStub.swift
//  ADNParqueaderoTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 28/03/23.
//

import Combine
@testable import Domain
@testable import Infraestructure

final class ExitVehicleServiceStub: ExitVehicleServiceProtocol {
    enum InteractorStubCase<T> {
        case success(() -> T)
        case failure(() -> Error)
    }
    
    private var exitCar: ExitVehicle?
    var responseHandler: InteractorStubCase<Any>
    
    init(exitCar: ExitVehicle?) {
        self.exitCar = exitCar
        responseHandler = .failure({
            CostumErrors.errorCoreData
        })
    }
    
    func retrieveExitVehicle(numerPlaque: String) -> AnyPublisher<Domain.ExitVehicle?, Error> {
        var publisher = CurrentValueSubject<Domain.ExitVehicle?, Error>(exitCar)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<Domain.ExitVehicle?, Error>(exitCar)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func deleteRegister(numerPlaque: String) -> AnyPublisher<Bool, Error> {
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
