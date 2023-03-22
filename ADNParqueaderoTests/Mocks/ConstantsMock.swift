//
//  ConstantsMock.swift
//  ADNParqueaderoTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 22/03/23.
//

import Foundation
@testable import Domain

public struct ConstantsMock {
    static let vehicles: [Domain.Vehicle] = [
        Vehicle(plaque: "ASF890",
                vehicleType: .motocicle,
                registerDate: getDateMock()),
        Vehicle(plaque: "FHFJF9",
                vehicleType: .car,
                registerDate: getDateMock())
    ]
    
    static func getDateMock() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "2023/03/22 22:31") ?? Date()
        return someDateTime
    }
}
