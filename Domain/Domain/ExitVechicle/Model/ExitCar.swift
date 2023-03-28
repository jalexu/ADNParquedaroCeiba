//
//  ExitCar.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//

public final class ExitCar: ExitVehicle {
    private var valueHourCar: Int = 1000
    private var valueDayCar: Int = 8000
    
    public init(plaqueId: String, registerDay: Date, exitDate: Date) {
        super.init(plaqueId: plaqueId,
                   registerDate: registerDay,
                   exitDate: exitDate,
                   valueHour: valueHourCar,
                   valueDay: valueDayCar)
    }
}
