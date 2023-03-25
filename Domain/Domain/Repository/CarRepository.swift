//
//  CarRepository.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import Combine

public protocol CarRepository {
    func save(with data: RegisterCar) -> AnyPublisher<Bool, Error>
    func retrieveObjects() -> AnyPublisher<Int, Error>
    func retrieveObject(numerPlaque: String) -> AnyPublisher<ExitCar?, Error>
    func delete(numerPlaque: String) -> AnyPublisher<Bool, Error>
}
