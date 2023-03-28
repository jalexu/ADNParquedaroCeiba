//
//  ResgisterCarRepositoryStub.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 27/03/23.
//

import Foundation
import Combine
@testable import Domain

final class ResgisterCarRepositoryStub: RegisterCarRepository {
    
    static var error: Error?
    static var responseDataExist: Bool = true
    static var numberCarsStored: Int = 2
    
    func saveCar(with data: Domain.RegisterVehicle) -> AnyPublisher<Bool, Error> {
        let subject = CurrentValueSubject<Bool, Error>(true)
        
        if let error = ResgisterCarRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func retrieveRegisterCar(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        let subject = CurrentValueSubject<Bool, Error>(ResgisterCarRepositoryStub.responseDataExist)
        
        if let error = ResgisterCarRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func retrieveNumberCars() -> AnyPublisher<Int, Error> {
        let subject = CurrentValueSubject<Int, Error>(ResgisterCarRepositoryStub.numberCarsStored)
        
        if let error = ResgisterCarRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
}
