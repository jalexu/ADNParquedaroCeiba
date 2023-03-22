//
//  VehicleWrapper.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import CoreData
import Domain

final class VehicleWrapper {
    static func mapVehicles(_ input: [NSManagedObject]?) -> [Domain.Vehicle] {
        var vehicles: [Domain.Vehicle] = []
        
        if let data = input {
            
            for vehicleData in data {
                if VehicleType(rawValue: vehicleData.value(forKey: "vehicleType") as! String) == .motocicle {
                    vehicles.append(
                        Motocicle(plaque: vehicleData.value(forKey: "plaqueId") as! String,
                                  vehicleType: VehicleType(rawValue: vehicleData.value(forKey: "vehicleType") as! String) ?? .motocicle,
                                  cylinderCapacity: vehicleData.value(forKey: "cylinderCapacity") as! String,
                                  registerDate:  vehicleData.value(forKey: "registerDate") as! Date))
                } else {
                    vehicles.append(Car(plaque: vehicleData.value(forKey: "plaqueId") as! String,
                                        vehicleType: VehicleType(rawValue: vehicleData.value(forKey: "vehicleType") as! String) ?? .motocicle,
                                        cylinderCapacity: vehicleData.value(forKey: "cylinderCapacity") as? String,
                                        registerDate:  vehicleData.value(forKey: "registerDate") as! Date))
                }
            }
            
            return vehicles
        }
        
        return vehicles
    }
    
    static func mapVehicle(_ input: NSManagedObject?) -> Domain.Vehicle? {
        var vehicle: Domain.Vehicle? = nil
        
        if let data = input {
            if VehicleType(rawValue: data.value(forKey: "vehicleType") as! String) == .motocicle {
                vehicle = Motocicle(plaque: data.value(forKey: "plaqueId") as! String,
                                    vehicleType: VehicleType(rawValue: data.value(forKey: "vehicleType") as! String) ?? .motocicle,
                                    cylinderCapacity: data.value(forKey: "cylinderCapacity") as! String,
                                    registerDate:  data.value(forKey: "registerDate") as! Date)
            } else {
                vehicle = Car(plaque: data.value(forKey: "plaqueId") as! String,
                              vehicleType: VehicleType(rawValue: data.value(forKey: "vehicleType") as! String) ?? .motocicle,
                              cylinderCapacity: data.value(forKey: "cylinderCapacity") as? String,
                              registerDate:  data.value(forKey: "registerDate") as! Date)
            }
            
            
            return vehicle
        }
        
        return vehicle
    }
}
