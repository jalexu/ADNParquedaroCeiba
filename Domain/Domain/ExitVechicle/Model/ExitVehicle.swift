//
//  ExitVehicle.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//

public class ExitVehicle {
    private let id: UUID = UUID()
    private var plaqueId: String
    private var registerDate: Date
    private var exitDate: Date
    private var valueToPay: Int = 0
    private var valueHour: Int
    private var valueDay: Int
    
    init(plaqueId: String,
         registerDate: Date,
         exitDate: Date,
         valueHour: Int,
         valueDay: Int) {
        self.plaqueId = plaqueId
        self.registerDate = registerDate
        self.exitDate = exitDate
        self.valueHour = valueHour
        self.valueDay = valueDay
    }
    
    public func totalToPay() -> Int {
        let hoursParking = getHoursAndDaysOfParking()
        
        if hoursParking.days >=  1 {
            valueToPay = (hoursParking.days * valueDay) + (hoursParking.hours * valueHour)
        } else if hoursParking.hours <= 9 {
            valueToPay = valueHour * hoursParking.hours
        } else {
            valueToPay = valueDay
        }
        
        return valueToPay
    }
    
    public func getHoursAndDaysOfParking() -> (hours: Int, days: Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .day], from: registerDate, to: exitDate)
        let hoursComponents = components.hour ?? 0
        let hours = hoursComponents == 0 ? 1 : hoursComponents
        let days = components.day ?? 0
        return (hours, days)
    }
    
}
