//
//  MotocicleTraslator.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import CoreData
import Domain

final class MotocicleTraslator {
    
    static func mapMotocicle(_ input: NSManagedObject?) -> Domain.ExitMotocicle? {
        var exitMotocicle: Domain.ExitMotocicle? = nil
        
        if let dataInput = input {
            let motocicleData = dataInput as? RegisterMotocicleEntity
            let motocicle = motocicleData?.motocicles?.allObjects as? [MotocicleEntity]
            
            let today = Date()
            exitMotocicle = ExitMotocicle(
                plaqueId: dataInput.value(forKey: "plaqueId") as! String,
                registerDay: dataInput.value(forKey: "registerDay") as! Date,
                exitDate: today,
                cylinderCapacity: motocicle?.first?.value(forKey: "cylinderCapacity") as! String)
            
            return exitMotocicle
        }
        
        return exitMotocicle
    }
}
