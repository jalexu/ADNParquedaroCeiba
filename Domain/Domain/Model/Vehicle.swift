//
//  Vehicle.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 17/03/23.
//

public class Vehicle {
    private var plaqueId: String
    private var vehicleType: VehicleType
    private var cylinderCapacity: String?
    private var registerDate: Date
    private var exceptionMessagePlaqueA: String = "No está autorizado a ingresar."
    
    public init(plaque: String, vehicleType: VehicleType, cylinderCapacity: String? = nil, registerDate: Date) {
        self.plaqueId = plaque
        self.vehicleType = vehicleType
        self.cylinderCapacity = cylinderCapacity
        self.registerDate = registerDate
    }
    
    public func getPlaqueId() -> String {
        plaqueId
    }
    
    public func getVehicleType() -> VehicleType {
        vehicleType
    }
    
    public func getCylinderCapacity() -> String {
       cylinderCapacity ?? "0"
    }
    
    public func getRegisterDate() -> Date {
        registerDate
    }
    
    public func validatePlaque() -> String {
        if plaqueId.first?.uppercased() == "A" && validateDaysForPlaqueA() {
            return exceptionMessagePlaqueA
        } else {
            return ""
        }
    }
    
    private func validateDaysForPlaqueA() -> Bool {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: registerDate)
        
        switch weekday {
        case 1, 2:
            return true
        default:
            return false
        }
    }
}

public enum VehicleType: String, CaseIterable {
    case car = "Car"
    case motocicle = "Motocicle"
    
    public init?(rawValue: String) {
        switch rawValue.lowercased() {
        case "car":
            self = .car
        default:
            self = .motocicle
        }
    }
}
