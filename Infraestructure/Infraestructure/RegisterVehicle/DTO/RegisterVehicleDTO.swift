//
//  RegisterVehicleDTO.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 4/04/23.
//

@_implementationOnly import RealmSwift

class RegisterVehicleDTO: Object {
    @Persisted var plaqueId: String = ""
    @Persisted var registerDay: Date

    convenience init(plaqueId: String, registerDay: Date) {
        self.init()
        self.plaqueId = plaqueId
        self.registerDay = registerDay
    }
}
