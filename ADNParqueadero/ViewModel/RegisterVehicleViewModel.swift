//
//  RegisterVehicleViewModel.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//


import SwiftUI
import Domain

class RegisterVehicleViewModel {
    private let textLimit = 6
    
    @Published var state = RegisterVehiculeState()
    
    init() {}
    
    private func registerDate() -> String {
        let hourDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: hourDate)
    }
    
}

extension RegisterVehicleViewModel: RegisterVehicleProtocol {
    func registerVehicle() {
        print(registerDate())
    }
}
