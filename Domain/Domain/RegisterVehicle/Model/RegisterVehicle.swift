//
//  RegisterVehicle.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

public enum VehicleErrors: Error {
    case plaqueAError(String)
    case exceedNumberVehicles(String)
    case fieldPlaqueError(String)
    case cylinderCapacity(String)
}

public class RegisterVehicle {
    private let id: UUID = UUID()
    private var registerDay: Date
    private var vehicle: Vehicle
    private let firstLetterA = "A"
    
    public init(vehicle: Vehicle, registerDay: Date) throws {
        self.vehicle = vehicle
        self.registerDay = registerDay
        try self.validatePlaqueA()
    }
    
    public func getRegisterDay() -> Date {
        registerDay
    }
    
    public func getId() -> UUID {
        id
    }
    
    public func getVehicle() -> Vehicle {
        vehicle
    }
    
    private func validatePlaqueA() throws {
        if vehicle.getPlaqueId().first?.uppercased() == firstLetterA && validateDaysForPlaqueA(registerDate: registerDay) {
            throw RegisterVehicleError.plaqueAError("No está autorizado a ingresar.")
        }
    }
    
    private func validateDaysForPlaqueA(registerDate: Date) -> Bool {
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
