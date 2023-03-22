//
//  PaymentParking+Inject.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 22/03/23.
//

import Resolver
import Infraestructure

extension Resolver {
    public static func registerPaymentParkingViewModel() {
        register(PaymentParkingViewModel.self) { resolver in
            PaymentParkingViewModel(coreDataRepository: resolver.resolve(CoreDataRepositoryProtocol.self))
        }
    }
}
