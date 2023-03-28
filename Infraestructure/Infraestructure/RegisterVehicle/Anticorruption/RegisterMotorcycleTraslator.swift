//
//  RegisterMotorcycleTraslator.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import CoreData
import Domain

final class RegisterMotorcycleTraslator {
    
    static func transformNSManagedObjectToExitMotorcycle(_ input: NSManagedObject?) -> Domain.ExitMotorcycle? {
        var exitMotocycle: Domain.ExitMotorcycle? = nil
        
        if let dataInput = input {
            let motocicleData = dataInput as? RegisterMotocicleEntity
            let motocicle = motocicleData?.motocicles?.allObjects as? [MotocicleEntity]
            
            let today = Date()
            exitMotocycle = ExitMotorcycle(
                plaqueId: dataInput.value(forKey: "plaqueId") as! String,
                registerDay: dataInput.value(forKey: "registerDay") as! Date,
                exitDate: today,
                cylinderCapacity: motocicle?.first?.value(forKey: "cylinderCapacity") as! String)
            
            return exitMotocycle
        }
        
        return exitMotocycle
    }
    
    static func tranformRegisterVehicleToRegisterMotocicleEntity(
        data: Domain.RegisterVehicle, context: NSManagedObjectContext) throws -> RegisterMotocicleEntity {
            let registerMotocicleDB = RegisterMotocicleEntity(context: context)
            
            guard let motorcycle = data.getVehicle() as? Motorcycle else {
                throw CostumErrors.dataDontFound
            }
            
            registerMotocicleDB.id = data.getId()
            registerMotocicleDB.plaqueId = motorcycle.getPlaqueId()
            registerMotocicleDB.registerDay = data.getRegisterDay()
            
            let motocicleDB = MotocicleEntity(context: context)
            motocicleDB.plaqueId = motorcycle.getPlaqueId()
            motocicleDB.cylinderCapacity = motorcycle.getCylinderCapacity()
            
            registerMotocicleDB.addToMotocicles(motocicleDB)
            
            return registerMotocicleDB
        }
    
    static func transformRegisterMotocicleEntityToRegisterMotocicleEntity(_ input: RegisterMotocicleEntity?) throws -> Domain.RegisterVehicle? {
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
