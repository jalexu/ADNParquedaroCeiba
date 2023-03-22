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
    private var numersOfCars: Int = 0
    private var numersOfMotocicles: Int = 0
    
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
    
    private func showAlert(messagePlaqueA: String) {
        updateState {
            state.messagePlaqueA = messagePlaqueA
            state.showMessagePlaqueA = true
        }
    }
    
}

extension RegisterVehicleViewModel: RegisterVehicleProtocol {
    func registerVehicle() {
        self.loading = true
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
                }, receiveValue: { [weak self] response in
                    debugPrint(response)
                    self?.loading = false
                })
                .store(in: &subscribers)
        } else {
            showAlert(messagePlaqueA: messagePlaqueA)
        }
    }
    
    func retrieveVehicle() {
        self.loading = true
        coreDataRepository.retrieveObjects()
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                debugPrint(error.localizedDescription)
                self?.loading = false
            }, receiveValue: { [weak self] response in
                for vehicle in response {
                    if vehicle is Motocicle {
                        self?.numersOfMotocicles += 1
                    } else {
                        self?.numersOfCars += 1
                    }
                }
                self?.loading = false
                self?.registerVehicle()
            })
            .store(in: &subscribers)
    }
}
