//
//  RegisterVehicleRepository.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import Combine

public protocol RegisterVehicleRepository {
    func save(with data: RegisterVehicle) -> AnyPublisher<Bool, Error>
    func retrieveByPlaque(numerPlaque: String) -> AnyPublisher<Bool, Error>
    func retrieveAll() -> AnyPublisher<[RegisterVehicle], Error>
}
