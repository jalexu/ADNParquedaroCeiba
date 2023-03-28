//
//  ExitCarRepositoryCoreData.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 28/03/23.
//

import Foundation
import CoreData
import Domain
import Combine

final class ExitCarRepositoryCoreData: ExitCarRepositoryProtocol {
    
    init() {}
    
    func retrieveExitCar(numerPlaque: String) -> AnyPublisher<Domain.ExitCar?, Error> {
        
        return Future { promise in
            DispatchQueue.global().async {
                let context = ConfigurationCoreDataBase.context
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterCarEntity")
                
                do {
                    let registerCarEntities = try context.fetch(fetchRequest) as? [RegisterCarEntity] ?? []
                    let registerCarEntity = registerCarEntities.first(where: { $0.plaqueId == numerPlaque })
                    
                    let vehicleData = ExitCarTraslator.transformNSManagedObjectToExitCar(registerCarEntity)
                    promise(.success(vehicleData))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteCar(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        return Future { promise in
            let context = ConfigurationCoreDataBase.context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterCarEntity")
            
            do {
                let result = try context.fetch(fetchRequest) as? [NSManagedObject]
                let vehicleToDelete = result?.first { $0.value(forKey: "plaqueId") as! String == numerPlaque }
                if vehicleToDelete != nil {
                    context.delete(vehicleToDelete!)
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

