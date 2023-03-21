//
//  ADNParqueaderoApp.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 14/03/23.
//

import SwiftUI

@main
struct ADNParqueaderoApp: App {
    private var viewModel = RegisterVehicleViewModel()
    var body: some Scene {
        WindowGroup {
            RegisterVehicleView(viewModel: viewModel)
        }
    }
}
