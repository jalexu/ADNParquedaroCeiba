//
//  ExitVehicleRepositoryStub.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 28/03/23.
//

import Foundation
import Combine
@testable import Domain

final class ExitVehicleRepositoryStub: ExitVehicleRepositoryProtocol {
    static var error: Error?
    
    func retrieveExitVehicle(numerPlaque: String) -> AnyPublisher<Domain.ExitVehicle?, Error> {
        let exitCar = Domain.ExitCar(plaqueId: "SDF789",
                                     registerDay: DomainTestMock.getRegisterDayMock(),
                                     exitDate: Date())
        let subject = CurrentValueSubject<Domain.ExitVehicle?, Error>(exitCar)
        
        if let error = ExitVehicleRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func deleteRegister(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        let subject = CurrentValueSubject<Bool, Error>(true)
        
        if let error = ExitVehicleRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
}
