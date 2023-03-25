//
//  RegisterMotocicle.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

public final class RegisterMotocicle: RegisterVehicle {
    private var motocicle: Motocicle
    private var capacityMotocicle: Int16 = 10
    
    public init(motocicle: Motocicle, registerDay: Date, numberMotocicle: Int) throws {
        self.motocicle = motocicle
        try super.init(plaqueId: motocicle.getPlaqueId(), registerDay: registerDay)
        try validateNumberMotocles(numberMotocicle: numberMotocicle)
    }
    
    public func getMotocicle() -> Motocicle {
        motocicle
    }
    
    func validateNumberMotocles(numberMotocicle: Int) throws {
        if numberMotocicle >= capacityMotocicle {
            throw VehicleError.exceedNumberVehicles("El parquedaro no puede recibir más motos.")
        }
    }
    
}
