//
//  ExitVehicle+Inject.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 22/03/23.
//

import Domain
import Factory

// MARK: Inject ExitVehicleViewModel
extension Container {
    var injectExitVehicleViewModel: Factory<ExitVehicleViewModel> {
        Factory(self) {
            ExitVehicleViewModel(exitVehicleService: self.injectExitVehicleService())
        }.singleton
    }
}
