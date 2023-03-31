//
//  RegisterVehicleRepositoryCoreData.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import CoreData
import Domain
import Combine

final class RegisterVehicleRepositoryCoreData: RegisterVehicleRepository {
    init() {}
    
    func save(with data: Domain.RegisterVehicle) -> AnyPublisher<Bool, Error> {
        return Future { promise in
            let context = ConfigurationCoreDataBase.context
            
            if ((data.getVehicle() as? Car) != nil) {
                RegisterCarTraslator.tranformRegisterVehicleToRegisterCarEntity(data: data, context: context)
            } else {
                RegisterMotorcycleTraslator.tranformRegisterVehicleToRegisterMotocicleEntity(data: data, context: context)
            }
            
            do {
                try context.save()
                debugPrint("We have been register Vehicule")
                promise(.success(true))
            } catch {
                debugPrint("Realm has error whent try to save data")
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func retrieveByPlaque(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        return Future { promise in
            var vehicle: NSManagedObject?
            let context = ConfigurationCoreDataBase.context
            let fetchRequestCar = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterCarEntity")
            let fetchRequestMotorcycle = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterMotocicleEntity")
            
            do {
                let registerCar = try context.fetch(fetchRequestCar) as? [NSManagedObject]
                let resultCar = registerCar?.first { $0.value(forKey: "plaqueId") as? String == numerPlaque }
                let registerMotorcycle = try context.fetch(fetchRequestMotorcycle) as? [NSManagedObject]
                let resultMotorcycle = registerMotorcycle?.first { $0.value(forKey: "plaqueId") as? String == numerPlaque }
                
                if resultCar != nil {
                    vehicle = resultCar
                } else if resultMotorcycle != nil {
                    vehicle = resultMotorcycle
                }
                promise(.success(vehicle != nil))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func retrieveAll() -> AnyPublisher<[RegisterVehicle], Error> {
        return Future { promise in
            DispatchQueue.global().async {
                var registerVehiclesData: [RegisterVehicle] = []
                let context = ConfigurationCoreDataBase.context
                let fetchRequestCar = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterCarEntity")
                let fetchRequestMotocicle = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterMotocicleEntity")
                
                do {
                    let resultCar = try context.fetch(fetchRequestCar) as? [RegisterCarEntity] ?? []
                    let resultMotorcycle = try context.fetch(fetchRequestMotocicle) as? [RegisterMotocicleEntity] ?? []
                    if !resultCar.isEmpty {
                        let data = try RegisterCarTraslator.entityToRegisterVehicle(entities: resultCar)
                        registerVehiclesData.append(contentsOf: data)
                    }
                    
                    if !resultMotorcycle.isEmpty {
                        let data = try RegisterMotorcycleTraslator.entityToRegisterVehicle(entities: resultMotorcycle)
                        registerVehiclesData.append(contentsOf: data)
                    }
                 
                    promise(.success(registerVehiclesData))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
