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
        register(RegisterCarRepository.self) {
            return CarRepositoryCoreData()
        }
        
        register(RegisterCarServiceProtocol.self) { resolver in
            return RegisterCarService(registerCarRepository: resolver.resolve(RegisterCarRepository.self))
        }
    }
    
    private static func registerRegisterMotocicleRepository() {
        register(RegisterMotorcycleRepository.self) {
            return MotorcycleRepositoryCoreData()
        }
        
        register(RegisterMotorcycleServiceProtocol.self) { resolver in
            return RegisterMotorcycleService(registerMotocicleRepository: resolver.resolve(RegisterMotorcycleRepository.self))
        }
    }
}


