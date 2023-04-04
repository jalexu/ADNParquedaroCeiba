//
//  RegisterVehicleRepositoryRealm.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import Foundation
import CoreData
import Domain
import Combine

final class RegisterVehicleRepositoryRealm {
    init() {}
    
    func saveCar(with data: Domain.RegisterVehicle) -> AnyPublisher<Bool, Error> {
        return Future { promise in
            let context = ConfigurationCoreDataBase.context
            
            do {
                RegisterCarTraslator.tranformRegisterVehicleToRegisterCarEntity(data: data, context: context)
                try context.save()
                debugPrint("We have been register vehicule")
                promise(.success(true))
            } catch {
                debugPrint("Realm has error whent try to save data")
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func retrieveNumberCars() -> AnyPublisher<Int, Error> {
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
    
    func retrieveRegisterCar(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        return Future { promise in
            let context = ConfigurationCoreDataBase.context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterCarEntity")
            
            do {
                let result = try context.fetch(fetchRequest) as? [NSManagedObject]
                let register = result?.first { $0.value(forKey: "plaqueId") as? String == numerPlaque }
                promise(.success(register != nil))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
