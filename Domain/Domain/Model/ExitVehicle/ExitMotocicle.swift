//
//  ExitMotocicle.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//

public final class ExitMotocicle: ExitVehicle {
    private var motorCapacity = 500
    private let extraPay: Int = 2000
    private var valueHourMotocicle: Int = 500
    private var valueDayMotocicle: Int = 4000
    private var cylinder: String
    
    public init(plaqueId: String, registerDay: Date, exitDate: Date, cylinderCapacity: String) {
        cylinder = cylinderCapacity
        super.init(plaqueId: plaqueId,
                   registerDate: registerDay,
                   exitDate: exitDate,
                   valueHour: valueHourMotocicle,
                   valueDay: valueDayMotocicle)
    }
    
    public override func totalToPay() -> Int {
        var valueToPay: Int  = 0
        let extraToPay = getPriceForCylinderCapacity()
        let hoursParking = getHoursAndDaysOfParking()
        
        if hoursParking.days >=  1 {
            valueToPay = (hoursParking.days * valueDayMotocicle) + (hoursParking.hours * valueHourMotocicle)
        } else if hoursParking.hours <= 9  {
            valueToPay = valueHourMotocicle * hoursParking.hours
        } else {
            valueToPay = valueDayMotocicle
        }
        valueToPay += extraToPay
        return valueToPay
    }
    
    private func getPriceForCylinderCapacity() -> Int {
        guard Int(cylinder) ?? 0 >= motorCapacity else {
            return 0
        }
        
        return extraPay
    }
}
