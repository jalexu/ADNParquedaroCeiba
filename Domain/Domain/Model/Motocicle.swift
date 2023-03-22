//
//  Motocicle.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 17/03/23.
//

public class Motocicle: Vehicle {
    private let extraPay: Int = 2000
    
    public init(plaque: String,
                vehicleType: VehicleType,
                cylinderCapacity: String,
                registerDate: Date) {
        super.init(plaque: plaque, vehicleType: vehicleType, cylinderCapacity: cylinderCapacity, registerDate: registerDate)
    }
    
    public func getPriceForCylinderCapacity() -> Int {
        guard let capacity = Int(getCylinderCapacity()), capacity >= 500 else {
            return 0
        }
        
        return extraPay
    }
}
