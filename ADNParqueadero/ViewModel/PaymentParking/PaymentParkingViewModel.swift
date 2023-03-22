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
    private let coreDataRepository: CoreDataRepositoryProtocol
    private var subscribers: Set<AnyCancellable> = []
    private var motocicle: Motocicle?
    private var isAmotocicle: Bool = false
    private var car: Car?
    private var isAcar: Bool = false

    
    private var storedData: Date?
    private var currentData: Date = Date()
    
    
    // MARK: -Price for type of vehicle
    private let valueHourCar = 1000
    private let valueDayCar = 8000
    private var valueHourMotocicle = 500
    private let valueDayMotocicle = 4000
    
    private var totalToPay = 0
    
    @Published var state = PaymentParkingState()
    
    init(coreDataRepository: CoreDataRepositoryProtocol) {
        self.coreDataRepository = coreDataRepository
    }
    
    private func updateState(updater: () -> Void) {
        updater()
        objectWillChange.send()
    }
    
    private func showValuesToPay() {
       
        let hoursParking = getHoursAndDaysOfParking()
        
        if hoursParking.hours <= 9 {
            if isAmotocicle {
                let extraPay = motocicle?.getPriceForCylinderCapacity() ?? 0
                totalToPay = valueHourMotocicle * hoursParking.hours
                totalToPay += extraPay
            } else {
                totalToPay = valueHourCar * hoursParking.hours
            }
        } else {
            if hoursParking.days == 0 {
                if isAmotocicle {
                    let extraPay = motocicle?.getPriceForCylinderCapacity() ?? 0
                    totalToPay = valueDayMotocicle
                    totalToPay += extraPay
                } else {
                    totalToPay = valueDayCar
                }
            } else {
                if isAmotocicle {
                    let extraPay = motocicle?.getPriceForCylinderCapacity() ?? 0
                    totalToPay = valueDayMotocicle * hoursParking.days
                    totalToPay += extraPay
                } else {
                    totalToPay = valueDayCar * hoursParking.days
                }
            }

        }
        
        updateState {
            state.hoursToPay = hoursParking.hours
            state.daysToPay = hoursParking.days
            state.valueToPay = totalToPay
        }
    }
    
    private func getHoursAndDaysOfParking() -> (hours: Int, days: Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .day], from: storedData!, to: currentData)
        let hours = components.hour ?? 0
        let days = components.day ?? 0
        return (hours, days)
    }
    
    private func getDaysOfParking() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: storedData!, to: currentData)
        let days = components.day ?? 0
        return days
    }
}

extension PaymentParkingViewModel: PaymentParkingProtocol {
    func searchVehicle(numberPlaque: String) {
        self.loading = true
        coreDataRepository.retrieveObject(numerPlaque: numberPlaque)
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                debugPrint(error.localizedDescription)
                self?.loading = false
            }, receiveValue: {
                [weak self] response in
                self?.loading = false
                if let vehicule = response {
                    if vehicule is Motocicle {
                        self?.motocicle = response as? Motocicle
                        self?.storedData = self?.motocicle?.getRegisterDate()
                        self?.isAmotocicle = true
                    } else {
                        self?.car = response as? Car
                        self?.storedData = self?.car?.getRegisterDate()
                        self?.isAcar = true
                    }
                    self?.showValuesToPay()
                    self?.updateState {
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
    
    func paymentVehicle() {
        
    }
    
    func deleteVehicle() {
        
    }
}

