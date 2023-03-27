//
//  CarService.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import Foundation
import Combine

public protocol CarServiceProtocol {
    func saveCar(with data: RegisterCar) -> AnyPublisher<Bool, Error>
    func retrieveCarObjects() -> AnyPublisher<Int, Error>
    func retrieveCarObject(numerPlaque: String) -> AnyPublisher<ExitCar?, Error>
    func deleteCar(numerPlaque: String) -> AnyPublisher<Bool, Error>
}

public class CarService: CarServiceProtocol {
    private let carRepository: CarRepository
    
    public init(carRepository: CarRepository) {
        self.carRepository = carRepository
    }
    
    public func saveCar(with data: RegisterCar) -> AnyPublisher<Bool, Error> {
        carRepository.saveCar(with: data)
    }
    
    public func retrieveCarObjects() -> AnyPublisher<Int, Error> {
        carRepository.retrieveCarObjects()
    }
    
    public func retrieveCarObject(numerPlaque: String) -> AnyPublisher<ExitCar?, Error> {
        carRepository.retrieveCarObject(numerPlaque: numerPlaque)
    }
    
    public func deleteCar(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        carRepository.deleteCar(numerPlaque: numerPlaque)
    }
}
