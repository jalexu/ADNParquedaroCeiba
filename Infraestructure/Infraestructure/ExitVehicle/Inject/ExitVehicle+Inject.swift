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
        register(ExitVehicleRepositoryProtocol.self) {
            return ExitVehicleRepositoryCoreData()
        }
        
        register(ExitVehicleServiceProtocol.self) { resolver in
            return ExitVehicleService(exitVehicleRepository: resolver.resolve(ExitVehicleRepositoryProtocol.self))
        }
    }
    
}

