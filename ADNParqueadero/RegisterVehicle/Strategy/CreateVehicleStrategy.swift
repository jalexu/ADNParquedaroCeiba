//
//  CreateVehicleStrategy.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 30/03/23.
//

import Foundation
import Domain

protocol CreateVehicleStrategy {
    func createVehicle(registerDate: Date) throws -> RegisterVehicle
}

struct CreateCar: CreateVehicleStrategy {
    private let plaqueId: String
    
    init(plaqueId: String) {
        self.plaqueId = plaqueId
    }
    
    func createVehicle(registerDate: Date) throws -> Domain.RegisterVehicle {
        let car = try Car(plaqueId: plaqueId)
        let registerVehicle = try RegisterVehicle(vehicle: car, registerDay: registerDate)
        return registerVehicle
    }
}

struct CreateMotorcycle: CreateVehicleStrategy {
    private let plaqueId: String
    private let cylinderCapacity: String
    
    init(plaqueId: String, cylinderCapacity: String) {
        self.plaqueId = plaqueId
        self.cylinderCapacity = cylinderCapacity
    }
    
    func createVehicle(registerDate: Date) throws -> Domain.RegisterVehicle {
        let motocicle = try Motorcycle(plaqueId: plaqueId, cylinderCapacity: cylinderCapacity)
        let registerVehicle = try RegisterVehicle(vehicle: motocicle, registerDay: registerDate)
        return registerVehicle
    }
}

