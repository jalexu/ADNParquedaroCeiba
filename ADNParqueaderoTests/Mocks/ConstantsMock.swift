//
//  ConstantsMock.swift
//  ADNParqueaderoTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 22/03/23.
//

import Foundation
@testable import Domain

public struct ConstantsMock {
    static let registerCars: [Domain.RegisterCar] = [
        try! RegisterCar(car: Car(plaqueId: "LSF890"),
                    registerDay: getDateMock(),
                    numberCars: 0),
        try! RegisterCar(car: Car(plaqueId: "TTF890"),
                    registerDay: getDateMock(),
                    numberCars: 1)
        
    ]
    
    static let registerMotocicles: [Domain.RegisterMotocicle] = [
        try! RegisterMotocicle(motocicle: Motocicle(plaqueId: "UIU908", cylinderCapacity: "200"),
                               registerDay: getDateMock(),
                               numberMotocicle: 0),
        try! RegisterMotocicle(motocicle: Motocicle(plaqueId: "KLM567", cylinderCapacity: "600"),
                               registerDay: getDateMock(),
                               numberMotocicle: 1)
    ]
    
    static func getDateMock() -> Date {
        let today: Date = Date()
        return today.addingTimeInterval(-7200)
    }
}
