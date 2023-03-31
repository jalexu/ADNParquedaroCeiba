//
//  RegisterVehicleRepositoryStub.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 27/03/23.
//

import Foundation
import Combine
@testable import Domain

final class RegisterVehicleRepositoryStub: RegisterVehicleRepository {
    
    static var error: Error?
    static var responseDataExist: Bool = true
    static var numberCarsStored: [Domain.RegisterVehicle] = []
    
    func save(with data: Domain.RegisterVehicle) -> AnyPublisher<Bool, Error> {
        let subject = CurrentValueSubject<Bool, Error>(true)
        
        if let error = RegisterVehicleRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func retrieveByPlaque(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        let subject = CurrentValueSubject<Bool, Error>(RegisterVehicleRepositoryStub.responseDataExist)
        
        if let error = RegisterVehicleRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func retrieveAll() -> AnyPublisher<[Domain.RegisterVehicle], Error> {
        RegisterVehicleRepositoryStub.numberCarsStored = [
            try! Domain.RegisterVehicle(
                vehicle: DomainTestMock.carMock,
                registerDay: DomainTestMock.getRegisterDayMock())
        ]
        
        let subject = CurrentValueSubject<[Domain.RegisterVehicle], Error>(RegisterVehicleRepositoryStub.numberCarsStored)
        
        if let error = RegisterVehicleRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
}
