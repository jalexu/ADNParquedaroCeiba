//
//  CarRepository.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import Combine

public protocol CarRepository {
    func saveCar(with data: RegisterCar) -> AnyPublisher<Bool, Error>
    func retrieveCarObjects() -> AnyPublisher<Int, Error>
    func retrieveCarObject(numerPlaque: String) -> AnyPublisher<ExitCar?, Error>
    func deleteCar(numerPlaque: String) -> AnyPublisher<Bool, Error>
}
