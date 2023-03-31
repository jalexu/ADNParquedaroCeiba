//
//  RegisterCarServiceStub.swift
//  ADNParqueaderoTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 22/03/23.
//

import Combine
@testable import Domain
@testable import Infraestructure

final class RegisterCarServiceStub: RegisterVehicleServiceProtocol {
    enum InteractorStubCase<T> {
        case success(() -> T)
        case failure(() -> Error)
    }
    
    private var vehicles: [Domain.RegisterVehicle] = []
    var exitCarObject: ExitCar?
    var responseHandler: InteractorStubCase<Any>
    
    init(vehicles: [Domain.RegisterVehicle] ) {
        self.vehicles = vehicles
        responseHandler = .failure({
            CostumErrors.errorCoreData
        })
    }
    
    func save(with data: Domain.RegisterVehicle) -> AnyPublisher<Bool, Error> {
        var publisher = CurrentValueSubject<Bool, Error>(true)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<Bool, Error>(true)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func retrieveAll() -> AnyPublisher<[Domain.RegisterVehicle], Error> {
        let stored = [
            try! Domain.RegisterVehicle(
                vehicle: Car(plaqueId: "IOD890"),
                registerDay: ConstantsMock.getDateMock())
        ]
        var publisher = CurrentValueSubject<[Domain.RegisterVehicle], Error>(stored)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<[Domain.RegisterVehicle], Error>(stored)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
