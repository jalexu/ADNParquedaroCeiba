//
//  VehicleError.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 27/03/23.
//

import Foundation

public enum VehicleError: Error {
    case cylinderCapacity(String)
    case plaqueAError(String)
    case fieldPlaqueError(String)
}
