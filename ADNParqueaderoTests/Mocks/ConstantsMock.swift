//
//  ConstantsMock.swift
//  ADNParqueaderoTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 22/03/23.
//

import Foundation
@testable import Domain

public struct ConstantsMock {
    static let registerVehiclesWithCarMock: [Domain.RegisterVehicle] = [
        try! RegisterVehicle(
            vehicle: Car(plaqueId: "LSF890"),
            registerDay: getDateMock()),
        try!RegisterVehicle(
            vehicle: Car(plaqueId: "TFD890"),
            registerDay: getDateMock())
    ]
    
    static let registerVehiclesWithMotorcycles: [Domain.RegisterVehicle] = [
        try! RegisterVehicle(vehicle: Motorcycle(plaqueId: "UIU908", cylinderCapacity: "200"),
                             registerDay: getDateMock()),
        try!RegisterVehicle(vehicle: Motorcycle(plaqueId: "KLM567", cylinderCapacity: "600"),
                            registerDay: getDateMock())
    ]
    
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
