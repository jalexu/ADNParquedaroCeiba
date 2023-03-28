//
//  ExitMotocycleRepositoryCoreData.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 28/03/23.
//

import CoreData
import Domain
import Combine

final class ExitMotocycleRepositoryCoreData: ExitMotocycleRepositoryProtocol {
    init() {}
    
    func retrieveMotocycle(numerPlaque: String) -> AnyPublisher<Domain.ExitMotorcycle?, Error> {
        return Future { promise in
            let context = ConfigurationCoreDataBase.context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterMotocicleEntity")
            
            do {
                let registerMotocicleEntities = try context.fetch(fetchRequest) as? [RegisterMotocicleEntity] ?? []
                let registerMotocicleEntity = registerMotocicleEntities.first(where: { $0.plaqueId == numerPlaque })
                let vehicleData = RegisterMotorcycleTraslator.transformNSManagedObjectToExitMotorcycle(registerMotocicleEntity)
                promise(.success(vehicleData))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteMotocycle(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        return Future { promise in
            let context = ConfigurationCoreDataBase.context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterMotocicleEntity")
            
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
