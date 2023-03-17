//
//  RegisterVehicle.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 17/03/23.
//

public struct RegisterVehicle {
    private var vehicle: Vehicle
    private var registerDate: Date
    
    public init(vehicle: Vehicle, registerDate: Date) {
        self.vehicle = vehicle
        self.registerDate = registerDate
    }
}
