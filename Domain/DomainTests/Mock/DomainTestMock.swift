//
//  DomainTestMock.swift
//  DomainTests
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 22/03/23.
//

import Foundation

class DomainTestMock {
    static func getDateMock() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "2023/03/22 22:31") ?? Date()
        return someDateTime
    }
    
    static func getDateWithMondayMock() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "2023/03/20 22:31") ?? Date()
        return someDateTime
    }
}
