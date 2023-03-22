//
//  RegisterVehiculeState.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import SwiftUI
import Domain

final class RegisterVehiculeState: ObservableObject {
    @Published var inputPlaque: String = "" {
        didSet {
            if inputPlaque.count > 6 {
                inputPlaque = String(inputPlaque.prefix(6)).uppercased()
            }
        }
    }
    var seletedVehicleType: VehicleType = VehicleType.car
    var inputVehicleType: String = ""
    var inputCylinderCapacity: String = ""
    var message: String = ""
    var showAlert: Bool = false
    var numersOfCars: Int = 0
    var numersOfMotocicles: Int = 0
}

