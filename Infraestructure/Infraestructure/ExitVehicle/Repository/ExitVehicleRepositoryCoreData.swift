//
//  ExitVehicleRepositoryCoreData.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 28/03/23.
//

import Foundation
import CoreData
import Domain
import Combine

final class ExitVehicleRepositoryCoreData: ExitVehicleRepositoryProtocol {
    
    init() {}
    
    func retrieveExitVehicle(numerPlaque: String) -> AnyPublisher<Domain.ExitVehicle?, Error> {
        
        return Future { promise in
            DispatchQueue.global().async {
                var vehicleData: ExitVehicle?
                let context = ConfigurationCoreDataBase.context
                let fetchRequestCar = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterCarEntity")
                let fetchRequestMotorcycle = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterMotocicleEntity")
                
                do {
                    let registerCarEntities = try context.fetch(fetchRequestCar) as? [RegisterCarEntity] ?? []
                    let registerCarEntity = registerCarEntities.first(where: { $0.plaqueId == numerPlaque })
                    let registerMotorcycleEntities = try context.fetch(fetchRequestMotorcycle) as? [RegisterMotocicleEntity] ?? []
                    let registerMotorcycleEntity = registerMotorcycleEntities.first(where: { $0.plaqueId == numerPlaque })
                    
                    if registerCarEntity != nil {
                        vehicleData = ExitCarTraslator.transformNSManagedObjectToExitCar(registerCarEntity)
                    } else {
                        vehicleData = ExitMotorcycleTraslator.transformNSManagedObjectToExitMotorcycle(registerMotorcycleEntity)
                    }
                    promise(.success(vehicleData))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteRegister(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        return Future { promise in
            let context = ConfigurationCoreDataBase.context
            let fetchRequestCar = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterCarEntity")
            let fetchRequestMotorcycle = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterMotocicleEntity")
            
            do {
                let resultcar = try context.fetch(fetchRequestCar) as? [NSManagedObject]
                let carToDelete = resultcar?.first { $0.value(forKey: "plaqueId") as? String == numerPlaque }
                let resultMotorcycle = try context.fetch(fetchRequestMotorcycle) as? [NSManagedObject]
                let motorcycleToDelete = resultMotorcycle?.first { $0.value(forKey: "plaqueId") as? String == numerPlaque }
                
                if carToDelete != nil {
                    context.delete(carToDelete!)
                    try context.save()
                    promise(.success(true))
                } else if motorcycleToDelete != nil {
                    context.delete(motorcycleToDelete!)
                    try context.save()
                    promise(.success(true))
                } else {
                    promise(.success(false))
                }
                
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
