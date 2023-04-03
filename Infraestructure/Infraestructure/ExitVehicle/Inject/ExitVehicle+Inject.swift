//
//  ExitVehicle+Inject.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//

import Domain
import Factory

// MARK: Inject ExitVehicleRepository
extension Container {
    var injectExitVehicleRepository: Factory<ExitVehicleRepositoryProtocol> {
        Factory(self) { ExitVehicleRepositoryCoreData() }.singleton
    }
    
    public var injectExitVehicleService: Factory<ExitVehicleServiceProtocol> {
        Factory(self) { ExitVehicleService(exitVehicleRepository: self.injectExitVehicleRepository()) }
    }
}
