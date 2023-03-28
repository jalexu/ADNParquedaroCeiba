//
//  RegisterCarService.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 27/03/23.
//

import Foundation
import Combine

public protocol RegisterCarServiceProtocol {
    func saveCar(with data: RegisterVehicle) -> AnyPublisher<Bool, Error>
    func retrieveNumberCars() -> AnyPublisher<Int, Error>
}

public class RegisterCarService: RegisterCarServiceProtocol {
    private let registerCarRepository: RegisterCarRepository
    
    public init(registerCarRepository: RegisterCarRepository) {
        self.registerCarRepository = registerCarRepository
    }
    
    public func saveCar(with data: RegisterVehicle) -> AnyPublisher<Bool, Error> {
        let capacityParkingCars: Int16 = 20
        let numerPlaque = data.getVehicle().getPlaqueId().uppercased()
        
        return Publishers.Zip(retrieveNumberCars(), retrieveRegisterCar(numerPlaque: numerPlaque))
            .flatMap { carsStored, vehicleExist -> AnyPublisher<Bool, Error> in
                
                guard capacityParkingCars > carsStored else {
                    return Fail<Bool, Error>(error: RegisterVehicleError.exceedNumberVehicles("El parquedaro no puede recibir mas carros."))
                        .eraseToAnyPublisher()
                }
                
                guard !(vehicleExist) else {
                    return Fail<Bool, Error>(error: RegisterVehicleError.vehicleExistError)
                        .eraseToAnyPublisher()
                }
                
                return self.registerCarRepository.saveCar(with: data)
            }
            .eraseToAnyPublisher()
    }
    
    public func retrieveNumberCars() -> AnyPublisher<Int, Error> {
        registerCarRepository.retrieveNumberCars()
    }
    
    private func retrieveRegisterCar(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        registerCarRepository.retrieveRegisterCar(numerPlaque: numerPlaque)
    }
    
}
