//
//  RegisterVehicleRealmModel.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 17/03/23.
//

import Foundation
@_implementationOnly import RealmSwift

class RegisterVehicleRealmModel: Object {
    @Persisted var plaqueId: String
    @Persisted var vehicleType: String
    @Persisted var cylinderCapacity: String
    @Persisted var registerDate: Date
    
    convenience init(
        plaqueId: String,
        vehicleType: String,
        cylinderCapacity: String,
        registerDate: Date) {
            self.init()
            self.plaqueId = plaqueId
            self.vehicleType = vehicleType
            self.cylinderCapacity = cylinderCapacity
            self.registerDate = registerDate
        }
}
