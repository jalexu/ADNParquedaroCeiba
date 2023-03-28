//
//  DomainTestMock.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 22/03/23.
//

import Foundation
@testable import Domain

class DomainTestMock {
    static func getRegisterDayMock() -> Date {
        let today: Date = Date()
        return today.addingTimeInterval(-7200)
    }
    
    static let carMock: Car = {
        try! Car(plaqueId: "JHU909")
    }()
    
    static let carPlaqueAMock: Car = {
        try! Car(plaqueId: "AIO789")
    }()
    
    static let motorcyclePlaqueAMock: Motorcycle = {
        try! Motorcycle(plaqueId: "ADIO99", cylinderCapacity: "200")
    }()
    
    static let motorcycleMock: Motorcycle = {
        try! Motorcycle(plaqueId: "LFG567", cylinderCapacity: "600")
    }()
    
    static func getregisterWithDaysMock() -> Date {
        let today: Date = Date()
        return today.addingTimeInterval(-86500)
    }

    static func getDateWithMondayMock() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "2023/03/20 22:31") ?? Date()
        return someDateTime
    }
    
    static let registerVehicleCarMock: RegisterVehicle = {
        try! RegisterVehicle(vehicle: carMock, registerDay: getRegisterDayMock())
    }()
    
    static let registerVehicleMotorcycleMock: RegisterVehicle = {
        try! RegisterVehicle(vehicle: motorcycleMock, registerDay: getRegisterDayMock())
    }()
    
    static let errorMock: Error = {
        NSError(domain:"Data does't exist", code: 500, userInfo:nil)
    }()
}
