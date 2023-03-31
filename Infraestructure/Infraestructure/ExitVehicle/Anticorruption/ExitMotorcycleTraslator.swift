//
//  ExitMotorcycleTraslator.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 29/03/23.
//

import CoreData
import Domain

final class ExitMotorcycleTraslator {
    static func transformNSManagedObjectToExitMotorcycle(_ input: NSManagedObject?) -> Domain.ExitMotorcycle? {
        var exitMotocycle: Domain.ExitMotorcycle? = nil
        
        if let dataInput = input {
            let motocicleData = dataInput as? RegisterMotocicleEntity
            let motocicle = motocicleData?.motocicles?.allObjects as? [MotocicleEntity]
            
            let today = Date()
            exitMotocycle = ExitMotorcycle(
                plaqueId: dataInput.value(forKey: "plaqueId") as? String ?? "",
                registerDay: dataInput.value(forKey: "registerDay") as? Date ?? Date(),
                exitDate: today,
                cylinderCapacity: motocicle?.first?.value(forKey: "cylinderCapacity") as? String ?? "")
            
            return exitMotocycle
        }
        
        return exitMotocycle
    }
}
