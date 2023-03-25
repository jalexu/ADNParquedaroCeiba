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
    
    private func searchCar(numberPlaque: String) {
        self.loading = true
        carService.retrieveObject(numerPlaque: numberPlaque.uppercased())
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
    
    private func searchMotocicle(numberPlaque: String) {
        self.loading = true
        motocicleService.retrieveObject(numerPlaque: numberPlaque.uppercased())
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

}

extension PaymentParkingViewModel: PaymentParkingProtocol {
    func searchVehicle(numberPlaque: String) {
        if state.seletedVehicleType == .car {
            searchCar(numberPlaque: numberPlaque)
        } else {
            searchMotocicle(numberPlaque: numberPlaque)
        }
    }
    
    func paymentVehicle() {
        if state.seletedVehicleType == .car {
            
        } else {
            
        }
    }
    
    func deleteVehicle() {
        
    }
}

