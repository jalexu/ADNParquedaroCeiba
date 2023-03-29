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

public class RegisterMotorcycleService: RegisterVehicleService {
    
    public override init(registerVehicleRepository: RegisterVehicleRepository) {
        super.init(registerVehicleRepository: registerVehicleRepository)
        self.vehicleCapacity = 10
    }
}
