//
//  RegisterCarDTO.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 3/04/23.
//

@_implementationOnly import RealmSwift

class RegisterCarDTO: Object {
    @Persisted var plaqueId: String = ""
    @Persisted var registerDay: Date

    convenience init(plaqueId: String, registerDay: Date) {
        self.init()
        self.plaqueId = plaqueId
        self.registerDay = registerDay
    }
}
