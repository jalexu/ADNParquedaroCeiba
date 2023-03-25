//
//  CarRepositoryCoreData.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import CoreData
import Domain
import Combine

final class CarRepositoryCoreData: CarRepository {
    
    init() {}
    
    func save(with data: Domain.RegisterCar) -> AnyPublisher<Bool, Error> {
        return Future { promise in
            let context = ConfigurationCoreDataBase.context
            
            let registerCarDB = RegisterCarEntity(context: context)
            registerCarDB.id = data.getId()
            registerCarDB.plaqueId = data.getCar().getPlaqueId()
            registerCarDB.registerDay = data.getRegisterDay()
            
            let cardDB = CarEntity(context: context)
            cardDB.plaqueId = data.getCar().getPlaqueId()
            
            registerCarDB.addToCars(cardDB)
            
            do {
                try context.save()
                debugPrint("We have been register vehicule")
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
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterCarEntity")
            
            do {
                let result = try context.fetch(fetchRequest)
                let vehicleData = result.count
                promise(.success(vehicleData))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func retrieveObject(numerPlaque: String) -> AnyPublisher<Domain.ExitCar?, Error> {
        return Future { promise in
            let context = ConfigurationCoreDataBase.context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterCarEntity")
            
            do {
                let registerCarEntities = try context.fetch(fetchRequest) as? [RegisterCarEntity] ?? []
                let registerCarEntity = registerCarEntities.first(where: { $0.plaqueId == numerPlaque })
                
                let vehicleData = CarTraslator.mapCar(registerCarEntity)
                promise(.success(vehicleData))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func delete(numerPlaque: String) -> AnyPublisher<Bool, Error> {
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
