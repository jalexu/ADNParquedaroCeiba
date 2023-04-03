//
//  ADNParqueadero+Inject.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import Domain
import Factory

// MARK: Inject RegisterVehicleViewModel
extension Container {
    var injectRegisterVehicleViewModel: Factory<RegisterVehicleViewModel> {
        Factory(self) {
            RegisterVehicleViewModel(registarVehicleService: self.injectRegisterVehicleService())
        }
    }
}
