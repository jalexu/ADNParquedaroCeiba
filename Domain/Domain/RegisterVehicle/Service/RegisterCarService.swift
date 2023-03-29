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

public class RegisterCarService: RegisterVehicleService {
    
    public override init(registerVehicleRepository: RegisterVehicleRepository) {
        super.init(registerVehicleRepository: registerVehicleRepository)
        self.vehicleCapacity = 20
    }
}
