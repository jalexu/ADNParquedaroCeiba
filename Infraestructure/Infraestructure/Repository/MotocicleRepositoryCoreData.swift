//
//  MotocicleRepositoryCoreData.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import CoreData
import Domain
import Combine

final class MotocicleRepositoryCoreData: MotocicleRepository {
    
    init() {}
    
    func save(with data: Domain.RegisterMotocicle) -> AnyPublisher<Bool, Error> {
        return Future { promise in
            let context = ConfigurationCoreDataBase.context
            
            let registerMotocicleDB = RegisterMotocicleEntity(context: context)
            registerMotocicleDB.id = data.getId()
            registerMotocicleDB.plaqueId = data.getMotocicle().getPlaqueId()
            registerMotocicleDB.registerDay = data.getRegisterDay()
            
            let motocicleDB = MotocicleEntity(context: context)
            motocicleDB.plaqueId = data.getMotocicle().getPlaqueId()
            motocicleDB.cylinderCapacity = data.getMotocicle().getCylinderCapacity()
            
            registerMotocicleDB.addToMotocicles(motocicleDB)
            
            do {
                try context.save()
                debugPrint("We have been register Motocicle")
                promise(.success(true))
            } catch {
                debugPrint("Realm has error whent try to save data")
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func retrieveObjects() -> AnyPublisher<Int, Error> {
        return Future { promise in
            let context = ConfigurationCoreDataBase.context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterMotocicleEntity")
            
            do {
                let result = try context.fetch(fetchRequest)
                let vehicleData = result.count
                promise(.success(vehicleData))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func retrieveObject(numerPlaque: String) -> AnyPublisher<Domain.ExitMotocicle?, Error> {
        return Future { promise in
            let context = ConfigurationCoreDataBase.context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterMotocicleEntity")
            
            do {
                let registerMotocicleEntities = try context.fetch(fetchRequest) as? [RegisterMotocicleEntity] ?? []
                let registerMotocicleEntity = registerMotocicleEntities.first(where: { $0.plaqueId == numerPlaque })
                let vehicleData = MotocicleTraslator.mapMotocicle(registerMotocicleEntity)
                promise(.success(vehicleData))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func delete(numerPlaque: String) -> AnyPublisher<Bool, Error> {
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
