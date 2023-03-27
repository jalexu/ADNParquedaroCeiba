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
    }
    
    private static func registerCarRepository() {
        register(CarRepository.self) {
            return CarRepositoryCoreData()
        }
        
        register(CarServiceProtocol.self) { resolver in
            return CarService(carRepository: resolver.resolve(CarRepository.self))
        }
    }
    
    private static func registerMotocicleRepository() {
        register(MotocicleRepository.self) {
            return MotocicleRepositoryCoreData()
        }
        
        register(MotocicleServiceProtocol.self) { resolver in
            return MotocicleService(motocicleRepository: resolver.resolve(MotocicleRepository.self))
        }
    }
    
}

