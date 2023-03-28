//
//  RegisterCarRepository.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import Combine


public protocol RegisterCarRepository {
    func saveCar(with data: RegisterVehicle) -> AnyPublisher<Bool, Error>
    func retrieveRegisterCar(numerPlaque: String) -> AnyPublisher<Bool, Error>
    func retrieveNumberCars() -> AnyPublisher<Int, Error>
}
