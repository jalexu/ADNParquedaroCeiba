//
//  RegisterVehicle+Inject.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 29/03/23.
//

import Domain
import Factory

// MARK: Inject RegisterVehicle
extension Container {
    
    public var injectRegisterVehicleRepository: Factory<RegisterVehicleRepository> {
        Factory(self) { RegisterVehicleRepositoryCoreData() }.singleton
    }
    
    public var injectRegisterVehicleService: Factory<RegisterVehicleServiceProtocol> {
        Factory(self) { RegisterMotorcycleService(registerVehicleRepository: self.injectRegisterVehicleRepository()) }
    }
}
