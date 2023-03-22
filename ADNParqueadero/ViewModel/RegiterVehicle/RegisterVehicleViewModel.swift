//
//  RegisterVehicleViewModel.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//


import SwiftUI
import Combine
import Domain
import Infraestructure

class RegisterVehicleViewModel: BaseViewModel {
    private let textLimit = 6
    private let coreDataRepository: CoreDataRepositoryProtocol
    
    private var subscribers: Set<AnyCancellable> = []
    
    @Published var state = RegisterVehiculeState()
    
    init(coreDataRepository: CoreDataRepositoryProtocol) {
        self.coreDataRepository = coreDataRepository
    }
    
    private func updateState(updater: () -> Void) {
        updater()
        objectWillChange.send()
    }
    
    private func registerDate() -> Date {
        let hourDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return hourDate
    }
    
    private func showAlert(message: String) {
        updateState {
            state.message = message
            state.showAlert = true
        }
    }
    
    private func numbersOfVehicles(vehicles: [Domain.Vehicle]) {
        for vehicle in vehicles {
            updateState {
                if vehicle.getVehicleType() == .motocicle {
                    state.numersOfMotocicles += 1
                } else {
                    state.numersOfCars += 1
                }
            }
        }
    }
    
}

extension RegisterVehicleViewModel: RegisterVehicleProtocol {
    func registerVehicle() {
        self.loading = true
        
        guard !state.inputPlaque.isEmpty else {
            self.loading = false
            showAlert(message: "Debe ingresar un número de placa.")
            return
        }
        
        let vehicle = Vehicle(plaque: state.inputPlaque,
                              vehicleType: state.seletedVehicleType,
                              cylinderCapacity: state.inputCylinderCapacity.isEmpty ? "0" : state.inputCylinderCapacity,
                              registerDate: registerDate())
        let messagePlaqueA = vehicle.validatePlaque()
        
        if messagePlaqueA.isEmpty {
            coreDataRepository.save(with: vehicle)
                .sink(receiveCompletion: { [weak self] completion in
                    guard case .failure(let error) = completion else { return }
                    debugPrint(error.localizedDescription)
                    self?.loading = false
                    self?.showAlert(message: "Error al guardar")
                }, receiveValue: { [weak self] response in
                    debugPrint(response)
                    self?.loading = false
                })
                .store(in: &subscribers)
        } else {
            showAlert(message: messagePlaqueA)
        }
    }
    
    func onAppear() {
        self.loading = true
        coreDataRepository.retrieveObjects()
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                debugPrint(error.localizedDescription)
                self?.loading = false
            }, receiveValue: { [weak self] response in
                self?.numbersOfVehicles(vehicles: response)
                self?.loading = false
            })
            .store(in: &subscribers)
    }
    
    func onDisappear() {
        state.numersOfCars = 0
        state.numersOfMotocicles = 0
        state.showAlert = false
    }
}
