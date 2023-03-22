//
//  CoreData+Inject.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import Resolver

extension Resolver {
    public static func registerCoreDataDependencies() {
        registerCoreDataRepository()
    }
    
    private static func registerCoreDataRepository() {
        register(CoreDataManagerProtocol.self) {
            return CoreDataManager()
        }
        
        register(CoreDataRepositoryProtocol.self) { resolver in
            return CoreDataRepository(coreDataManager: resolver.resolve(CoreDataManagerProtocol.self))
        }
    }
    
}
