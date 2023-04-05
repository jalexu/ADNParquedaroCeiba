//
//  ExitCarTraslator.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 28/03/23.
//

import CoreData
import Domain

final class ExitCarTraslator {
    static func transformNSManagedObjectToExitCar(_ input: NSManagedObject?) -> Domain.ExitCar? {
        var exitCar: Domain.ExitCar? = nil
        if let dataInput = input {
            let today = Date()
            exitCar = Domain.ExitCar(plaqueId: dataInput.value(forKey: "plaqueId") as? String ?? "",
                                     registerDay: dataInput.value(forKey: "registerDay") as? Date ?? Date(),
                                     exitDate: today)
            
            return exitCar
        }
        
        return exitCar
    }
    
    static func registerCarDTOToExitCar(carDTO: RegisterCarDTO) -> ExitCar {
        ExitCar(plaqueId: carDTO.plaqueId,
                registerDay: carDTO.registerDay,
                exitDate: Date())
    }
}
