//
//  CarTraslator.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import CoreData
import Domain

final class CarTraslator {
    static func mapCar(_ input: NSManagedObject?) -> Domain.ExitCar? {
        var exitCar: Domain.ExitCar? = nil
        if let dataInput = input {
            let today = Date()
            exitCar = Domain.ExitCar(plaqueId: dataInput.value(forKey: "plaqueId") as! String,
                                     registerDay: dataInput.value(forKey: "registerDay") as! Date,
                                     exitDate: today)
            
            return exitCar
        }
        
        return exitCar
    }
}
