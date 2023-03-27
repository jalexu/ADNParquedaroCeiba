//
//  PaymentParkingState.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import SwiftUI


final class PaymentParkingState: ObservableObject {
    var valueToPay: Int = 0
    var hoursToPay: Int = 0
    var daysToPay: Int = 0
    var showFildsPay: Bool = false
    var showMessage: Bool = false
    var showError: Bool = false
    var inputNumberPlaque: String = ""
    var seletedVehicleType: VehicleType = VehicleType.car
}
