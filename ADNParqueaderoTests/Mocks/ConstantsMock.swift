//
//  ConstantsMock.swift
//  ADNParqueaderoTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 22/03/23.
//

import Foundation
@testable import Domain

public struct ConstantsMock {
    static func registerVehiclesWithCarMock() throws -> [Domain.RegisterVehicle] {
        var registerVehicles: [Domain.RegisterVehicle] = []
        var registerVehicle: RegisterVehicle
        
        registerVehicle = try Domain.RegisterVehicle(
            vehicle: Car(plaqueId: "LSF890"),
            registerDay: getDateMock())
        
        registerVehicles.append(registerVehicle)
        
        registerVehicle = try RegisterVehicle(
            vehicle: Car(plaqueId: "TFD890"),
            registerDay: getDateMock())
           
        registerVehicles.append(registerVehicle)
            
        return registerVehicles
    }
    
    static func registerVehiclesWithMotorcycles() throws -> [Domain.RegisterVehicle] {
        var registerVehicles: [Domain.RegisterVehicle] = []
        var registerVehicle: RegisterVehicle
        
        registerVehicle = try RegisterVehicle(vehicle: Motorcycle(plaqueId: "UIU908", cylinderCapacity: "200"),
                                              registerDay: getDateMock())
        
        registerVehicles.append(registerVehicle)
        
        registerVehicle = try RegisterVehicle(vehicle: Motorcycle(plaqueId: "KLM567", cylinderCapacity: "600"),
                                              registerDay: getDateMock())
        
        registerVehicles.append(registerVehicle)
        
        return registerVehicles
    }
    
    static let exitCarMock: ExitCar = {
        return ExitCar(plaqueId: "ASF890",
                       registerDay: ConstantsMock.getDateMock(),
                       exitDate: Date())
    }()
    
    static let exitMotorcycle: ExitMotorcycle = {
        return ExitMotorcycle(plaqueId: "ASF890",
                              registerDay: ConstantsMock.getDateMock(),
                              exitDate: Date(),
                              cylinderCapacity: "200")
    }()
    
    static func getDateMock() -> Date {
        let today: Date = Date()
        return today.addingTimeInterval(-7200)
    }
}
