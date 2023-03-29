//
//  RegisterVehicle+Inject.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 29/03/23.
//

import Resolver
import Domain

extension Resolver {
    public static func registerRegisterVehicleRepositoryDependencies() {
        registerRegisterCarRepository()
        registerRegisterMotocicleRepository()
    }
    
    private static func registerRegisterCarRepository() {
        register(RegisterVehicleRepository.self) {
            return RegisterVehicleRepositoryCoreData()
        }
        
        register(RegisterVehicleServiceProtocol.self) { resolver in
            return RegisterCarService(registerVehicleRepository: resolver.resolve(RegisterVehicleRepository.self))
        }
    }
    
    private static func registerRegisterMotocicleRepository() {
        register(RegisterVehicleRepository.self) {
            return RegisterVehicleRepositoryCoreData()
        }
        
        register(RegisterVehicleServiceProtocol.self) { resolver in
            return RegisterMotorcycleService(registerVehicleRepository: resolver.resolve(RegisterVehicleRepository.self))
        }
    }
}


