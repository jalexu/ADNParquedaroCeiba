//
//  PaymentParking+Inject.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 22/03/23.
//

import Resolver
import Domain

extension Resolver {
    public static func registerPaymentParkingViewModel() {
        register(PaymentParkingViewModel.self) { resolver in
            PaymentParkingViewModel(carService: resolver.resolve(CarServiceProtocol.self),
                                    motocicleService: resolver.resolve(MotocicleServiceProtocol.self))
        }
    }
}
