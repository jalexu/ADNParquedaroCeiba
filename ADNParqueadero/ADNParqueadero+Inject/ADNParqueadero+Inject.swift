//
//  ADNParqueadero+Inject.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 22/03/23.
//

import Resolver
import Infraestructure

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerCoreDataDependencies()
        registerRegisterVehicleViewModel()
        registerPaymentParkingViewModel()
    }
}
