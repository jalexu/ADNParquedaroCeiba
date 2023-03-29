//
//  ExitVehicleViewModel.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import Combine
import Domain
import Infraestructure

final class ExitVehicleViewModel: BaseViewModel {
    private let carService: ExitCarServiceProtocol
    private let motocicleService: ExitMotorcycleServiceProtocol
    private var subscribers: Set<AnyCancellable> = []
    
    private var storedData: Date?
    private var currentData: Date = Date()
    
    @Published var state = ExitVehicleState()
    
    init(carService: ExitCarServiceProtocol,
         motocicleService: ExitMotorcycleServiceProtocol) {
        self.carService = carService
        self.motocicleService = motocicleService
    }
    
    private func updateState(updater: () -> Void) {
        updater()
        objectWillChange.send()
    }
    
    private func deleteCar() {
        self.loading = true
        carService.deleteCar(numerPlaque: state.inputNumberPlaque.uppercased())
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                debugPrint(error.localizedDescription)
                self?.state.showError = true
                self?.loading = false
            }, receiveValue: { [weak self] _ in
                self?.resetState()
                self?.loading = false
            })
            .store(in: &subscribers)
    }
    
    private func deleteMotocicle() {
        self.loading = true
        motocicleService.deleteMotorcycle(numerPlaque: state.inputNumberPlaque.uppercased())
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                debugPrint(error.localizedDescription)
                self?.state.showError = true
                self?.loading = false
            }, receiveValue: { [weak self] _ in
                self?.resetState()
                self?.loading = false
            })
            .store(in: &subscribers)
    }
    
    private func resetState() {
        updateState {
            state.showError = false
            state.valueToPay = 0
            state.showFildsPay = false
            state.hoursToPay = 0
            state.daysToPay = 0
            state.inputNumberPlaque = ""
        }
    }
    
}

extension ExitVehicleViewModel: ExitVehicleProtocol {
    func searchCar() {
        self.loading = true
        carService.retrieveExitCar(numerPlaque: state.inputNumberPlaque.uppercased())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                debugPrint(error.localizedDescription)
                self?.state.showError = true
                self?.loading = false
            }, receiveValue: { [weak self] response in
                self?.loading = false
                
                if let carResponse = response {
                    let hoursAndDaysToPay = carResponse.getHoursAndDaysOfParking()
                    self?.updateState {
                        self?.state.hoursToPay = hoursAndDaysToPay.hours
                        self?.state.daysToPay = hoursAndDaysToPay.days
                        self?.state.valueToPay = carResponse.totalToPay()
                        self?.state.showFildsPay = true
                    }
                } else {
                    self?.updateState {
                        self?.state.showMessage = true
                    }
                }
            })
            .store(in: &subscribers)
    }
    
    func searchMotocicle() {
        self.loading = true
        motocicleService.retrieveMotocycle(numerPlaque: state.inputNumberPlaque.uppercased())
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                debugPrint(error.localizedDescription)
                self?.state.showError = true
                self?.loading = false
            }, receiveValue: { [weak self] response in
                self?.loading = false
                
                if let motocicleResponse = response {
                    let hoursAndDaysToPay = motocicleResponse.getHoursAndDaysOfParking()
                    self?.updateState {
                        self?.state.hoursToPay = hoursAndDaysToPay.hours
                        self?.state.daysToPay = hoursAndDaysToPay.days
                        self?.state.valueToPay = motocicleResponse.totalToPay()
                        self?.state.showFildsPay = true
                    }
                } else {
                    self?.updateState {
                        self?.state.showMessage = true
                    }
                }
            })
            .store(in: &subscribers)
    }
    
    func paymentCar() {
        deleteCar()
    }
    
    func paymentMotocicle() {
        deleteMotocicle()
    }
    
    func onDisappear() {
        resetState()
    }
}

