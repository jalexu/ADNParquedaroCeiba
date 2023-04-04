//
//  RegisterMotorcycleDTO.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 4/04/23.
//

@_implementationOnly import RealmSwift

class RegisterMotorcycleDTO: Object {
    @Persisted var registerDay: Date
    @Persisted var plaqueId: String = ""
    @Persisted var cylinderCapacity: String = ""

    convenience init(plaqueId: String, cylinderCapacity: String, registerDay: Date) {
        self.init()
        self.plaqueId = plaqueId
        self.cylinderCapacity = cylinderCapacity
        self.registerDay = registerDay
    }
}
