//
//  RegisterCarTraslator.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import CoreData
import Domain

final class RegisterCarTraslator {
    static func tranformRegisterVehicleToRegisterCarEntity(
        data: Domain.RegisterVehicle, context: NSManagedObjectContext) throws -> RegisterCarEntity {
            let registerCarDB = RegisterCarEntity(context: context)
            
            guard let car = data.getVehicle() as? Car else {
                throw CostumErrors.dataDontFound
            }
            registerCarDB.id = data.getId()
            registerCarDB.plaqueId = car.getPlaqueId()
            registerCarDB.registerDay = data.getRegisterDay()
            
            let cardDB = CarEntity(context: context)
            cardDB.plaqueId = car.getPlaqueId()
            
            registerCarDB.addToCars(cardDB)
            
            return registerCarDB
        }
}
