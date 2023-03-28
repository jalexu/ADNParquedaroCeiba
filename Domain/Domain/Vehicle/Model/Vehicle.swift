//
//  Vehicle.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 17/03/23.
//


public class Vehicle {
    private var plaqueId: String
    
    public init(plaqueId: String) throws {
        self.plaqueId = plaqueId
        try validateEmptyPlaque()
        try validateNumbersCaracterPlaque()
    }
    
    public func getPlaqueId() -> String {
        plaqueId
    }
    
    private func validateEmptyPlaque() throws {
        if plaqueId.isEmpty {
            throw VehicleError.fieldPlaqueError("Ingresa por favor la placa del vehiculo.")
        }
    }
    
    private func validateNumbersCaracterPlaque() throws {
        if plaqueId.count < 6 {
            throw VehicleError.fieldPlaqueError("Placa incorrecta debe tener 6 caracteres")
        }
    }
    
    
}
