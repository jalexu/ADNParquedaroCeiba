//
//  ADNParqueadero+Inject.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import Resolver
import Infraestructure

extension Resolver {
    public static func registerRegisterVehicleViewModel() {
        register(RegisterVehicleViewModel.self) { resolver in
            RegisterVehicleViewModel(coreDataRepository: resolver.resolve(CoreDataRepositoryProtocol.self))
        }
    }
}
