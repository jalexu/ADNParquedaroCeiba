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
    
    static let motociclePlaqueAMock: Motocicle = {
        try! Motocicle(plaqueId: "ADIO99", cylinderCapacity: "200")
    }()
    
    static let motocicleMock: Motocicle = {
        try! Motocicle(plaqueId: "LFG567", cylinderCapacity: "600")
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
    
    static let registerCarMock: RegisterCar = {
        try! RegisterCar(car: carMock,
                         registerDay: getRegisterDayMock(),
                         numberCars: 0)
    }()
    
    static let errorMock: Error = {
        NSError(domain:"Data does't exist", code: 500, userInfo:nil)
    }()
}
