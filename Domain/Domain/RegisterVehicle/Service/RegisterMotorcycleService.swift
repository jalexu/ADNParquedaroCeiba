//
//  RegisterMotorcycleService.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 27/03/23.
//

import Foundation
import Combine

public protocol RegisterMotorcycleServiceProtocol {
    func saveMotorcycle(with data: RegisterVehicle) -> AnyPublisher<Bool, Error>
    func retrieveMotorcycles() -> AnyPublisher<Int, Error>
}

public class RegisterMotorcycleService: RegisterMotorcycleServiceProtocol {
    
    private let registerMotorcycleRepository: RegisterMotorcycleRepository
    
    public init(registerMotocicleRepository: RegisterMotorcycleRepository) {
        self.registerMotorcycleRepository = registerMotocicleRepository
    }
    
    public func saveMotorcycle(with data: RegisterVehicle) -> AnyPublisher<Bool, Error> {
        let capacityParkingMotorcycles: Int16 = 10
        
        return Publishers.Zip(retrieveMotorcycles(), retrieveRegisterVehicle(numerPlaque: data.getVehicle().getPlaqueId()))
            .flatMap { (motocyclesStored, vehicleExist) -> AnyPublisher<Bool, Error> in
                
                guard capacityParkingMotorcycles > motocyclesStored else {
                    return Fail<Bool, Error>(error: RegisterVehicleError
                        .exceedNumberVehicles(Constants.exceedNumberVehiclesMessage)
                    ).eraseToAnyPublisher()
                }
                
                guard !(vehicleExist) else {
                    return Fail<Bool, Error>(error: RegisterVehicleError
                        .vehicleExistError(Constants.vehicleExisteMessage)
                    ).eraseToAnyPublisher()
                }
                
                return self.registerMotorcycleRepository.saveMotocicle(with: data)
            }
            .eraseToAnyPublisher()
    }
    
    public func retrieveMotorcycles() -> AnyPublisher<Int, Error> {
        registerMotorcycleRepository.retrieveMotorcycles()
    }
    
    private func retrieveRegisterVehicle(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        registerMotorcycleRepository.retrieveRegisterMotorcycle(numerPlaque: numerPlaque)
    }
    
}
