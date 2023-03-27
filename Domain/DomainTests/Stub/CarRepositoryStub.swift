//
//  CarRepositoryStub.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 27/03/23.
//

import Foundation
import Combine
@testable import Domain

final class CarRepositoryStub: CarRepository {
    static var error: Error?
    
    func saveCar(with data: Domain.RegisterCar) -> AnyPublisher<Bool, Error> {
        let subject = CurrentValueSubject<Bool, Error>(true)
        
        if let error = CarRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func retrieveCarObjects() -> AnyPublisher<Int, Error> {
        let subject = CurrentValueSubject<Int, Error>(2)
        
        if let error = CarRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func retrieveCarObject(numerPlaque: String) -> AnyPublisher<Domain.ExitCar?, Error> {
        let exitCar = Domain.ExitCar(plaqueId: "SDF789",
                                     registerDay: DomainTestMock.getRegisterDayMock(),
                                     exitDate: Date())
        let subject = CurrentValueSubject<Domain.ExitCar?, Error>(exitCar)
        
        if let error = CarRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func deleteCar(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        let subject = CurrentValueSubject<Bool, Error>(true)
        
        if let error = CarRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
}
