//
//  ExitVehicle+Inject.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 22/03/23.
//

import Resolver
import Domain

extension Resolver {
    public static func exitVehicleViewModel() {
        register(ExitVehicleViewModel.self) { resolver in
            ExitVehicleViewModel(exitVehicleService: resolver.resolve(ExitVehicleServiceProtocol.self))
        }
    }
}
