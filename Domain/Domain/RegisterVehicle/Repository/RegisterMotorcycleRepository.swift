//
//  RegisterMotorcycleRepository.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import Combine

public protocol RegisterMotorcycleRepository {
    func saveMotocicle(with data: RegisterVehicle) -> AnyPublisher<Bool, Error>
    func retrieveRegisterMotorcycle(numerPlaque: String) -> AnyPublisher<Bool, Error>
    func retrieveMotorcycles() -> AnyPublisher<Int, Error>
}
