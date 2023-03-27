//
//  MotocicleRepository.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import Combine

public protocol MotocicleRepository {
    func saveMotocicle(with data: RegisterMotocicle) -> AnyPublisher<Bool, Error>
    func retrieveMotocicleObjects() -> AnyPublisher<Int, Error>
    func retrieveMotocicleObject(numerPlaque: String) -> AnyPublisher<ExitMotocicle?, Error>
    func deleteMotocicle(numerPlaque: String) -> AnyPublisher<Bool, Error>
}
