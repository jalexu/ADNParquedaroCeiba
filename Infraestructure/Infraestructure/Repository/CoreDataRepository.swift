//
//  CoreDataRepository.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import Combine
import Domain

public protocol CoreDataRepositoryProtocol {
    func save(with data: Domain.Vehicle) -> AnyPublisher<Bool, Error>
    func retrieveObjects() -> AnyPublisher<[Domain.Vehicle], Error>
    func retrieveObject(numerPlaque: String) -> AnyPublisher<Domain.Vehicle?, Error>
    func delete(numerPlaque: String) -> AnyPublisher<Bool, Error>
}

public class CoreDataRepository: CoreDataRepositoryProtocol {
    private let coreDataManager: CoreDataManagerProtocol
    
    public init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    public func save(with data: Domain.Vehicle) -> AnyPublisher<Bool, Error> {
        coreDataManager.save(with: data)
    }
    
    public func retrieveObjects() -> AnyPublisher<[Domain.Vehicle], Error> {
        coreDataManager.retrieveObjects()
    }
    
    public func delete(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        coreDataManager.delete(numerPlaque: numerPlaque)
    }
    
    public func retrieveObject(numerPlaque: String) -> AnyPublisher<Domain.Vehicle?, Error> {
        coreDataManager.retrieveObject(numerPlaque: numerPlaque)
    }
}
