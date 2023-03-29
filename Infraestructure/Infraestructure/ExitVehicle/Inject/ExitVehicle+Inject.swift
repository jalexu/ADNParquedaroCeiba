//
//  ExitVehicle+Inject.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//

import Resolver
import Domain

extension Resolver {
    public static func registerExitVehicleRepositoryDependencies() {
        registerExitCarService()
        registerExitMotorcycleService()
    }
    
    private static func registerExitCarService() {
        register(ExitCarRepositoryProtocol.self) {
            return ExitCarRepositoryCoreData()
        }
        
        register(ExitCarServiceProtocol.self) { resolver in
            return ExitCarService(exitCarRepository: resolver.resolve(ExitCarRepositoryProtocol.self))
        }
    }
    
    private static func registerExitMotorcycleService() {
        register(ExitMotocycleRepositoryProtocol.self) {
            return ExitMotocycleRepositoryCoreData()
        }
        
        register(ExitMotorcycleServiceProtocol.self) { resolver in
            return ExitMotorcycleService(exitMotocicleRepository: resolver.resolve(ExitMotocycleRepositoryProtocol.self))
        }
    }
    
}

