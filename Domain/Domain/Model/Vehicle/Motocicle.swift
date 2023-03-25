//
//  Motocicle.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 17/03/23.
//

public class Motocicle: Vehicle {
    private var cylinderCapacity: String
    
    public init(plaqueId: String, cylinderCapacity: String) throws {
        self.cylinderCapacity = cylinderCapacity
        try super.init(plaqueId: plaqueId)
    }
    
    public func getCylinderCapacity()-> String {
        cylinderCapacity
    }
}
