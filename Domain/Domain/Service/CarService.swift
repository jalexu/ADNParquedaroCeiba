//
//  CarService.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import Foundation
import Combine

public protocol CarServiceProtocol {
    func save(with data: RegisterCar) -> AnyPublisher<Bool, Error>
    func retrieveObjects() -> AnyPublisher<Int, Error>
    func retrieveObject(numerPlaque: String) -> AnyPublisher<ExitCar?, Error>
    func delete(numerPlaque: String) -> AnyPublisher<Bool, Error>
}

public class CarService: CarServiceProtocol {
    private let carRepository: CarRepository
    
    public init(carRepository: CarRepository) {
        self.carRepository = carRepository
    }
    
    public func save(with data: RegisterCar) -> AnyPublisher<Bool, Error> {
        carRepository.save(with: data)
    }
    
    public func retrieveObjects() -> AnyPublisher<Int, Error> {
        carRepository.retrieveObjects()
    }
    
    public func retrieveObject(numerPlaque: String) -> AnyPublisher<ExitCar?, Error> {
        carRepository.retrieveObject(numerPlaque: numerPlaque)
    }
    
    public func delete(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        carRepository.delete(numerPlaque: numerPlaque)
    }
}
