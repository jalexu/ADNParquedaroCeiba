//
//  CoreDataRepository.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import Combine
import Domain

public protocol CoreDataRepositoryProtocol {
    func save(with data: Domain.Vehicle) -> Future<Bool, Error>
    func retrieveObjects() -> Future<[Domain.Vehicle], Error>
    func retrieveObject(numerPlaque: String) -> Future<Domain.Vehicle?, Error>
    func delete(numerPlaque: String) -> Future<Bool, Error>
}

public class CoreDataRepository: CoreDataRepositoryProtocol {
    private let coreDataManager: CoreDataManagerProtocol
    
    public init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    public func save(with data: Domain.Vehicle) -> Future<Bool, Error> {
        coreDataManager.save(with: data)
    }
    
    public func retrieveObjects() -> Future<[Domain.Vehicle], Error> {
        coreDataManager.retrieveObjects()
    }
    
    public func delete(numerPlaque: String) -> Future<Bool, Error> {
        coreDataManager.delete(numerPlaque: numerPlaque)
    }
    
    public func retrieveObject(numerPlaque: String) -> Future<Domain.Vehicle?, Error> {
        coreDataManager.retrieveObject(numerPlaque: numerPlaque)
    }
}
