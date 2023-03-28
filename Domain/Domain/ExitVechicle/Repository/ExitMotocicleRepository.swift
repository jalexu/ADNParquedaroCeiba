//
//  ExitMotocycleRepository.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 27/03/23.
//

import Combine

public protocol ExitMotocycleRepositoryProtocol {
    func retrieveMotocycle(numerPlaque: String) -> AnyPublisher<ExitMotorcycle?, Error>
    func deleteMotocycle(numerPlaque: String) -> AnyPublisher<Bool, Error>
}
