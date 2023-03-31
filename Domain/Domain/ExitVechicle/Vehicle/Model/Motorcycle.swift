//
//  Motorcycle.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 17/03/23.
//

public class Motorcycle: Vehicle {
    private var cylinderCapacity: String
    
    public init(plaqueId: String, cylinderCapacity: String) throws {
        self.cylinderCapacity = cylinderCapacity
        try super.init(plaqueId: plaqueId)
        try self.validateCylinderCapacity()
    }
    
    public func getCylinderCapacity() -> String {
        cylinderCapacity
    }
    
    private func validateCylinderCapacity() throws {
        if cylinderCapacity.isEmpty {
            throw VehicleError.cylinderCapacity("Debes ingresar el cilindraje de la motocicleta.")
        }
    }
}
