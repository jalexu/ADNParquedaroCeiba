//
//  ExitVehicleState.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import SwiftUI

final class ExitVehicleState: ObservableObject {
    var inputNumberPlaque: String = "" {
        didSet {
            if inputNumberPlaque.count > 6 {
                inputNumberPlaque = String(inputNumberPlaque.prefix(6)).uppercased()
            }
        }
    }
    var valueToPay: Int = 0
    var hoursToPay: Int = 0
    var daysToPay: Int = 0
    var showFildsPay: Bool = false
    var showMessage: Bool = false
    var showError: Bool = false
    var seletedVehicleType: VehicleType = VehicleType.car
}
