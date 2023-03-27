//
//  ADNParqueaderoApp.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 14/03/23.
//

import SwiftUI
import Resolver

@main
struct ADNParqueaderoApp: App {
    private let viewModel = Resolver.resolve(RegisterVehicleViewModel.self)
    var body: some Scene {
        WindowGroup {
            InitialPageView()
        }
    }
}
