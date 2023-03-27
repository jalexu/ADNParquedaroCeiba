//
//  RegisterVehiculeContract.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import Combine

protocol RegisterVehicleProtocol: ObservableObject {
    var state: RegisterVehiculeState { get set }
    func registerCar(completion: @escaping () -> Void)
    func registerMotocicle(completion: @escaping () -> Void)
    func onAppear()
    func onDisappear()
}

