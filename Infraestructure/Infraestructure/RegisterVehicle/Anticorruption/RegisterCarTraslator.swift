//
//  RegisterCarTraslator.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import CoreData
import Domain

final class RegisterCarTraslator {
    @discardableResult
    static func tranformRegisterVehicleToRegisterCarEntity(
        data: Domain.RegisterVehicle, context: NSManagedObjectContext) -> RegisterCarEntity? {
            guard let car = data.getVehicle() as? Car else {
                return nil
            }
            
            let registerCarDB = RegisterCarEntity(context: context)
            registerCarDB.id = data.getId()
            registerCarDB.plaqueId = car.getPlaqueId()
            registerCarDB.registerDay = data.getRegisterDay()
            
            let cardDB = CarEntity(context: context)
            cardDB.plaqueId = car.getPlaqueId()
            
            registerCarDB.addToCars(cardDB)
            
            return registerCarDB
        }
    
    static func entityToRegisterVehicle(entities: [RegisterCarEntity]) throws -> [RegisterVehicle] {
        var vehicleData: [RegisterVehicle] = []
        vehicleData = try entities.map { entity in
            let registerVehicle = try RegisterVehicle(
                vehicle: toCar(entities: entity.cars?.allObjects as? [CarEntity] ?? []),
                registerDay: entity.registerDay ?? Date())
            return  registerVehicle
        }
        
        return vehicleData
    }
    
    static private func toCar(entities: [CarEntity])  throws -> Car {
        return try Car(plaqueId: entities.first?.plaqueId ?? "")
    }
}
