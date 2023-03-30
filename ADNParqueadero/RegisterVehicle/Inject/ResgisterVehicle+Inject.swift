//
//  ADNParqueadero+Inject.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import Resolver
import Domain

extension Resolver {
    public static func registerRegisterVehicleViewModel() {
        register(RegisterVehicleViewModel.self) { resolver in
            RegisterVehicleViewModel(registerCarService: resolver.resolve(RegisterVehicleServiceProtocol.self),
                                     registerMotocicleService: resolver.resolve(RegisterVehicleServiceProtocol.self))
        }
    }
}
