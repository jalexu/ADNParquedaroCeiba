//
//  Vehicle.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 17/03/23.
//

public class Vehicle {
    private var plaqueId: String
    private var vehicleType: VehicleType
    private var cylinderCapacity: Int?
    private var exceptionMessagePlaqueA: String = "No está autorizado a ingresar."
    
    public init(plaque: String, vehicleType: VehicleType, cylinderCapacity: Int? = nil) {
        self.plaqueId = plaque
        self.vehicleType = vehicleType
        self.cylinderCapacity = cylinderCapacity
    }
    
    func getCylinderCapacity() -> Int? {
        return cylinderCapacity
    }
    
    func validatePlaque() -> String {
        if plaqueId.first?.uppercased() == "A" {
            return exceptionMessagePlaqueA
        } else {
            return ""
        }
    }
}

public enum VehicleType: String, CaseIterable {
    case car = "Car"
    case motocicle = "Motocicle"
    case other = "Other"
    
    public init?(rawValue: String) {
        switch rawValue.lowercased() {
        case "car":
            self = .car
        case "motocicle":
            self = .motocicle
        default:
            self = .other
        }
    }
}
