//
//  RegisterVehicleError.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 27/03/23.
//

import Foundation

public enum RegisterVehicleError: Error {
    case exceedNumberVehicles(String)
    case fieldPlaqueError(String)
    case plaqueAError(String)
    case vehicleExistError
}
