//
//  RegisterCar.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import Foundation

public final class RegisterCar: RegisterVehicle {
    private var car: Car
    private var capacityCars: Int16 = 20
    
    public init(car: Car, registerDay: Date, numberCars: Int) throws {
        self.car = car
        try super.init(plaqueId: car.getPlaqueId(), registerDay: registerDay)
        try validateNumberCars(numberCars: numberCars)
    }
    
    public func getCar() -> Car {
        car
    }
    
    private func validateNumberCars(numberCars: Int) throws {
        if numberCars >= capacityCars {
            throw VehicleError.exceedNumberVehicles("El parquedaro no puede recibir mas carros.")
        }
    }
    
}
