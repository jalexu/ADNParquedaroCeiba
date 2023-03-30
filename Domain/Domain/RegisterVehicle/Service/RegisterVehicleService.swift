//
//  RegisterVehicleService.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 29/03/23.
//

import Foundation
import Combine


public protocol RegisterVehicleServiceProtocol {
    func save(with data: RegisterVehicle) -> AnyPublisher<Bool, Error>
    func retrieveAll() -> AnyPublisher<[RegisterVehicle], Error>
}

public protocol VehicleCapacityProtocol {
    var vehicleCapacity: Int { get set }
}

public class RegisterVehicleService: RegisterVehicleServiceProtocol, VehicleCapacityProtocol {
    private let registerVehicleRepository: RegisterVehicleRepository
    public var vehicleCapacity: Int = 0
    
    public init(registerVehicleRepository: RegisterVehicleRepository) {
        self.registerVehicleRepository = registerVehicleRepository
    }
    
    public func save(with data: RegisterVehicle) -> AnyPublisher<Bool, Error> {
        
        return Publishers.Zip(retrieveAll(), retrieveRegisterVehicle(numerPlaque: data.getVehicle().getPlaqueId()))
            .flatMap { (vehiclesStored, vehicleExist) -> AnyPublisher<Bool, Error> in
                let numbervehiclesStored = self.numberVehicleStoredForType(data: vehiclesStored, vehicle: data.getVehicle())
                
                guard self.vehicleCapacity > numbervehiclesStored else {
                    return Fail<Bool, Error>(error: RegisterVehicleError
                        .exceedNumberVehicles(Constants.exceedNumberVehiclesMessage)
                    ).eraseToAnyPublisher()
                }
                
                guard !(vehicleExist) else {
                    return Fail<Bool, Error>(error: RegisterVehicleError
                        .vehicleExistError(Constants.vehicleExisteMessage)
                    ).eraseToAnyPublisher()
                }
                
                return self.registerVehicleRepository.save(with: data)
            }
            .eraseToAnyPublisher()
    }
    
    public func retrieveAll() -> AnyPublisher<[RegisterVehicle], Error> {
        registerVehicleRepository.retrieveAll()
    }
    
    private func retrieveRegisterVehicle(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        registerVehicleRepository.retrieveByPlaque(numerPlaque: numerPlaque)
    }
    
    private func numberVehicleStoredForType(data: [RegisterVehicle], vehicle: Vehicle) -> Int {
        if ((vehicle as? Car) != nil) {
            return data.map({ $0.getVehicle() as? Car}).count
        } else {
            return data.map({ $0.getVehicle() as? Motorcycle}).count
        }
    }

    
}

