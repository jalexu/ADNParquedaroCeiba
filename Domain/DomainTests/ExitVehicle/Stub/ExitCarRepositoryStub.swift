//
//  ExitCarRepositoryStub.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 28/03/23.
//

import Foundation
import Combine
@testable import Domain

final class ExitCarRepositoryStub: ExitCarRepositoryProtocol {
    
    static var error: Error?
    
    func retrieveExitCar(numerPlaque: String) -> AnyPublisher<Domain.ExitCar?, Error> {
        let exitCar = Domain.ExitCar(plaqueId: "SDF789",
                                     registerDay: DomainTestMock.getRegisterDayMock(),
                                     exitDate: Date())
        let subject = CurrentValueSubject<Domain.ExitCar?, Error>(exitCar)
        
        if let error = ExitCarRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func deleteCar(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        let subject = CurrentValueSubject<Bool, Error>(true)
        
        if let error = ExitCarRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    
}
