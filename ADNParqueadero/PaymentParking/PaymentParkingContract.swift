//
//  PaymentParkingContract.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import Combine


protocol PaymentParkingProtocol: ObservableObject {
    var state: PaymentParkingState { get set }
    func searchCar()
    func searchMotocicle()
    func paymentCar()
    func paymentMotocicle()
    func onDisappear()
}

