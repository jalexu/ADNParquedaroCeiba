//
//  CoreData+Inject.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//

import Resolver
import Domain

extension Resolver {
    public static func registerCoreDataDependencies() {
        registerCarRepository()
        registerMotocicleRepository()
        registerExitCarService()
        registerExitMotorcycleService()
    }
    
    private static func registerCarRepository() {
        register(RegisterCarRepository.self) {
            return CarRepositoryCoreData()
        }
        
        register(RegisterCarServiceProtocol.self) { resolver in
            return RegisterCarService(registerCarRepository: resolver.resolve(RegisterCarRepository.self))
        }
    }
    
    private static func registerMotocicleRepository() {
        register(RegisterMotorcycleRepository.self) {
            return MotorcycleRepositoryCoreData()
        }
        
        register(RegisterMotorcycleServiceProtocol.self) { resolver in
            return RegisterMotorcycleService(registerMotocicleRepository: resolver.resolve(RegisterMotorcycleRepository.self))
        }
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

