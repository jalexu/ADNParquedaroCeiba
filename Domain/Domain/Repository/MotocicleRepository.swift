//
//  MotocicleRepository.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import Combine

public protocol MotocicleRepository {
    func save(with data: RegisterMotocicle) -> AnyPublisher<Bool, Error>
    func retrieveObjects() -> AnyPublisher<Int, Error>
    func retrieveObject(numerPlaque: String) -> AnyPublisher<ExitMotocicle?, Error>
    func delete(numerPlaque: String) -> AnyPublisher<Bool, Error>
}
