//
//  RealmManagerStub.swift
//  InfraestructureTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 5/04/23.
//

import Foundation
import Combine
@testable import Infraestructure
@_implementationOnly import RealmSwift

final class RealmManagerStub: RealmManagerProtocol {
    var motorcyclesDTO: RegisterMotorcycleDTO = RegisterMotorcycleDTO(plaqueId: "QWER456",
                                                                      cylinderCapacity: "200",
                                                                      registerDay: Date())
    
    var carsDTO: RegisterCarDTO = RegisterCarDTO(plaqueId: "QWER456",
                                                 registerDay: Date())
    var isCar: Bool = true
    var error: Error?
    
    func save<T>(dto: T) -> AnyPublisher<Bool, Error> where T : Object {
        let subject = CurrentValueSubject<Bool, Error>(true)
        
        if let error = error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func fetchObjects<T: Object>(_ type: T.Type) -> AnyPublisher<[T], Never> {
        var subject = CurrentValueSubject<[T], Never>(Array(_immutableCocoaArray: carsDTO))
        if !isCar {
            subject = CurrentValueSubject<[T], Never>(Array(_immutableCocoaArray: motorcyclesDTO))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func fetchObject<T: Object>(plaqueId: String, _ type: T.Type) -> AnyPublisher<T?, Never> {
        var subject = CurrentValueSubject<T?, Never>(carsDTO as? T)
        if !isCar {
            subject = CurrentValueSubject<T?, Never>(motorcyclesDTO as? T)
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func delete<T>(plaqueId: String, _ type: T.Type) -> AnyPublisher<Bool, Error> where T : Object {
        let subject = CurrentValueSubject<Bool, Error>(true)
        
        if let error = error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
}
