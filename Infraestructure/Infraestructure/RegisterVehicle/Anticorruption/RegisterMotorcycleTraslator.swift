//
//  RegisterMotorcycleTraslator.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import CoreData
import Domain

final class RegisterMotorcycleTraslator {
    @discardableResult
    static func tranformRegisterVehicleToRegisterMotocicleEntity(
        data: Domain.RegisterVehicle, context: NSManagedObjectContext) -> RegisterMotocicleEntity? {
            guard let motorcycle = data.getVehicle() as? Motorcycle else {
                return nil
            }
            
            let registerMotocicleDB = RegisterMotocicleEntity(context: context)
            registerMotocicleDB.id = data.getId()
            registerMotocicleDB.plaqueId = motorcycle.getPlaqueId()
            registerMotocicleDB.registerDay = data.getRegisterDay()
            
            let motocicleDB = MotocicleEntity(context: context)
            motocicleDB.plaqueId = motorcycle.getPlaqueId()
            motocicleDB.cylinderCapacity = motorcycle.getCylinderCapacity()
            
            registerMotocicleDB.addToMotocicles(motocicleDB)
            
            return registerMotocicleDB
        }
    
    static func entityToRegisterVehicle(entities: [RegisterMotocicleEntity]) throws -> [RegisterVehicle] {
        var vehicleData: [RegisterVehicle] = []
        vehicleData = try entities.map { entity in
            let registerVehicle = try RegisterVehicle(
                vehicle: toMotorcicly(entities: entity.motocicles?.allObjects as? [MotocicleEntity] ?? []),
                registerDay: entity.registerDay!)
            return  registerVehicle
        }
        
        return vehicleData
    }
    
    static private func toMotorcicly(entities: [MotocicleEntity]) throws -> Motorcycle {
        return try Motorcycle(plaqueId: entities.first?.plaqueId ?? "",
                              cylinderCapacity: entities.first?.cylinderCapacity ?? "")
    }
    
    static func transformRegisterMotocicleEntityToRegisterMotocicleEntity(_ input: RegisterMotocicleEntity?)
    throws -> Domain.RegisterVehicle? {
        var registerVehicle: Domain.RegisterVehicle? = nil
        
        guard let dataInput = input,
              let motocicleEntity = dataInput.motocicles?.allObjects as? [MotocicleEntity] else {
            throw CostumErrors.dataDontFound
        }
        
        let motocicle = try Motorcycle(plaqueId: motocicleEntity.first?.plaqueId ?? "",
                                       cylinderCapacity: motocicleEntity.first?.cylinderCapacity ?? "0")
        registerVehicle = try Domain.RegisterVehicle(vehicle: motocicle,
                                                     registerDay: dataInput.registerDay ?? Date())
        
        return registerVehicle
    }
}
