//
//  PaymentParkingViewModel.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import Combine
import Domain
import Infraestructure

final class PaymentParkingViewModel: BaseViewModel {
    private let carService: CarServiceProtocol
    private let motocicleService: MotocicleServiceProtocol
    private var subscribers: Set<AnyCancellable> = []
    
    private var storedData: Date?
    private var currentData: Date = Date()
    
    
    // MARK: -Price for type of vehicle
    private let valueHourCar = 1000
    private let valueDayCar = 8000
    private var valueHourMotocicle = 500
    private let valueDayMotocicle = 4000
    
    private var totalToPay = 0
    
    @Published var state = PaymentParkingState()
    
    init(carService: CarServiceProtocol,
         motocicleService: MotocicleServiceProtocol) {
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
        motocicleService.deleteMotocicle(numerPlaque: state.inputNumberPlaque.uppercased())
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

extension PaymentParkingViewModel: PaymentParkingProtocol {
    func searchCar() {
        self.loading = true
        carService.retrieveCarObject(numerPlaque: state.inputNumberPlaque.uppercased())
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
        motocicleService.retrieveMotocicleObject(numerPlaque: state.inputNumberPlaque.uppercased())
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
}
