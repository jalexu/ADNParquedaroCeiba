//
//  RegisterVehicle.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

public enum VehicleError: Error {
    case plaqueAError(String)
    case exceedNumberVehicles(String)
    case fieldPlaqueError(String)
    case cylinderCapacity(String)
}


public class RegisterVehicle {
    private let id: UUID = UUID()
    private var plaqueId: String
    private var registerDay: Date
    
    public init(plaqueId: String, registerDay: Date) throws {
        self.plaqueId = plaqueId
        self.registerDay = registerDay
        try self.validatePlaqueA()
    }
    
    public func getRegisterDay() -> Date {
        registerDay
    }
    
    public func getId() -> UUID {
        id
    }
    
    private func validatePlaqueA() throws {
        if plaqueId.first?.uppercased() == "A" && validateDaysForPlaqueA(registerDate: registerDay) {
            throw VehicleError.plaqueAError("No está autorizado a ingresar.")
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
