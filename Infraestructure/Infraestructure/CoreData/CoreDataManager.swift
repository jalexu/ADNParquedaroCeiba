//
//  CoreDataManager.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import CoreData
import Combine
import Domain

public final class CoreDataManager: CoreDataManagerProtocol {
    
    public init() {}
    
    public func save(with data: Domain.Vehicle) -> Future<Bool, Error> {
        Future<Bool, Error> { promise in
            let context = CoreDataService.context
            let entity = NSEntityDescription.entity(forEntityName: "Vehicle", in: context)!
            let table = NSManagedObject(entity: entity, insertInto: context)
            
            table.setValue(data.getPlaqueId(), forKey: "plaqueId")
            table.setValue(data.getVehicleType().rawValue, forKey: "vehicleType")
            table.setValue(data.getCylinderCapacity(), forKey: "cylinderCapacity")
            table.setValue(data.getRegisterDate(), forKey: "registerDate")
            
            do {
                try context.save()
                debugPrint("We have been register vehicule")
                promise(.success(true))
            } catch {
                debugPrint("Realm has error whent try to save data")
                promise(.failure(error))
            }
            
        }
    }
    
    public func retrieveObjects() -> Future<[Domain.Vehicle], Error> {
        Future<[Domain.Vehicle], Error> { promise in
            let context = CoreDataService.context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Vehicle")
            
            do {
                let result = try context.fetch(fetchRequest)
                let vehicleData = VehicleWrapper.mapVehicles(result as? [NSManagedObject])
                promise(.success(vehicleData))
            } catch {
                promise(.failure(error))
            }
        }
    }
    
    public func retrieveObject(numerPlaque: String) -> Future<Domain.Vehicle?, Error> {
        Future<Domain.Vehicle?, Error> { promise in
            let context = CoreDataService.context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Vehicle")
            
            do {
                let result = try context.fetch(fetchRequest) as? [NSManagedObject]
                let searchVehicle = result?.first { $0.value(forKey: "plaqueId") as! String == numerPlaque }
                let vehicleData = VehicleWrapper.mapVehicle(searchVehicle)
                promise(.success(vehicleData))
            } catch {
                promise(.failure(error))
            }
        }
    }
    
    public func delete(numerPlaque: String) -> Future<Bool, Error> {
        Future<Bool, Error> { promise in
            let context = CoreDataService.context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Vehicle")
            
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
        }
    }
}
