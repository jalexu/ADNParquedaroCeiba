//
//  ExitMotorcycleRepositoryStub.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 28/03/23.
//

import Foundation
import Combine
@testable import Domain

final class ExitMotorcycleRepositoryStub: ExitMotocycleRepositoryProtocol {
    static var error: Error?
    
    func retrieveMotocycle(numerPlaque: String) -> AnyPublisher<Domain.ExitMotorcycle?, Error> {
        let exitCar = Domain.ExitMotorcycle(plaqueId: "SDF789",
                                            registerDay: DomainTestMock.getRegisterDayMock(),
                                            exitDate: Date(),
                                            cylinderCapacity: "600")
        let subject = CurrentValueSubject<Domain.ExitMotorcycle?, Error>(exitCar)
        
        if let error = ExitMotorcycleRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func deleteMotocycle(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        let subject = CurrentValueSubject<Bool, Error>(true)
        
        if let error = ExitMotorcycleRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
}
