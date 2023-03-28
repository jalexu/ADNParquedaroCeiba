//
//  RegisterMotorcycleServiceStub.swift
//  ADNParqueaderoTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 25/03/23.
//

import Combine
@testable import Domain
@testable import Infraestructure

final class RegisterMotorcycleServiceStub: RegisterMotorcycleServiceProtocol {
    enum InteractorStubCase<T> {
        case success(() -> T)
        case failure(() -> Error)
    }
    
    private var vehicles: [Domain.RegisterVehicle] = []
    var responseHandler: InteractorStubCase<Any>
    
    init(vehicles: [Domain.RegisterVehicle] ) {
        self.vehicles = vehicles
        responseHandler = .failure({
            CostumErrors.errorCoreData
        })
    }
    
    func saveMotorcycle(with data: Domain.RegisterVehicle) -> AnyPublisher<Bool, Error> {
        var publisher = CurrentValueSubject<Bool, Error>(true)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<Bool, Error>(true)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func retrieveMotorcycles() -> AnyPublisher<Int, Error> {
        var publisher = CurrentValueSubject<Int, Error>(vehicles.count)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<Int, Error>(vehicles.count)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
}
