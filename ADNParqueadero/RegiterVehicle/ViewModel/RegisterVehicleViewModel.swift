//
//  RegisterVehicleViewModel.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import Foundation
import SwiftUI
import Combine
import Domain
import Infraestructure

class RegisterVehicleViewModel: BaseViewModel {
    private let registerCarService: RegisterVehicleServiceProtocol
    private let registerMotocicleService: RegisterVehicleServiceProtocol
    
    private var subscribers: Set<AnyCancellable> = []
    
    @Published var state = RegisterVehiculeState()
    
    init(registerCarService: RegisterVehicleServiceProtocol,
         registerMotocicleService: RegisterVehicleServiceProtocol) {
        self.registerCarService = registerCarService
        self.registerMotocicleService = registerMotocicleService
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
    
    private func hiddeLoading() {
        self.loading = false
    }
    
    private func showRegisterVehicleError(error: RegisterVehicleError) {
        switch error {
        case .vehicleExistError(let errorDescription):
            showAlert(message: "\(errorDescription)")
        case .exceedNumberVehicles(let errorDescription):
            showAlert(message: "\(errorDescription)")
        default:
            break
        }
    }
}

// MARK: -SaveCar
extension RegisterVehicleViewModel {
    private func saveCar(with data: RegisterVehicle, completion: @escaping () -> Void) {
        registerCarService.save(with: data)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.hiddeLoading()
                if let registerError = error as? RegisterVehicleError  {
                    self?.showRegisterVehicleError(error: registerError)
                } else {
                    self?.showAlert(message: Constants.errorMessageSaving)
                }
            }, receiveValue: { [weak self] response in
                debugPrint(response)
                self?.hiddeLoading()
                completion()
            })
            .store(in: &subscribers)
    }
}

// MARK: -SaveMotorcycle
extension RegisterVehicleViewModel {
    private func saveMotocicle(with data: RegisterVehicle, completion: @escaping () -> Void) {
        registerMotocicleService.save(with: data)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                debugPrint(error.localizedDescription)
                self?.hiddeLoading()
                if let registerError = error as? RegisterVehicleError  {
                    self?.showRegisterVehicleError(error: registerError)
                } else {
                    self?.showAlert(message: Constants.errorMessageSaving)
                }
            }, receiveValue: { [weak self] response in
                debugPrint(response)
                self?.hiddeLoading()
                completion()
            })
            .store(in: &subscribers)
    }
}

extension RegisterVehicleViewModel: RegisterVehicleProtocol {
    func registerCar(completion: @escaping () -> Void) {
        self.loading = true
        
        do {
            let registerDay = registerDate()
            let car = try Car(plaqueId: state.inputPlaque)
            let registerCar = try RegisterVehicle(vehicle: car, registerDay: registerDay)
            
            saveCar(with: registerCar) {
                completion()
            }
            
        } catch VehicleError.plaqueAError(let error) {
            hiddeLoading()
            showAlert(message: error)
        }  catch VehicleError.fieldPlaqueError(let error) {
            hiddeLoading()
            showAlert(message: error)
        } catch {
            hiddeLoading()
            showAlert(message: Constants.errorMessageSaving)
        }
    }
    
    func registerMotocicle(completion: @escaping () -> Void) {
        self.loading = true
        
        do {
            let registerDay = registerDate()
            let motocicle = try Motorcycle(plaqueId: state.inputPlaque, cylinderCapacity: state.inputCylinderCapacity)
            let registerMotocicle = try RegisterVehicle(vehicle: motocicle, registerDay: registerDay)
            
            saveMotocicle(with: registerMotocicle) {
                completion()
            }
            
        } catch VehicleError.plaqueAError(let error) {
            hiddeLoading()
            showAlert(message: error)
        } catch VehicleError.fieldPlaqueError(let error) {
            hiddeLoading()
            showAlert(message: error)
        } catch VehicleError.cylinderCapacity(let error) {
            hiddeLoading()
            showAlert(message: error)
        } catch {
            hiddeLoading()
            showAlert(message: Constants.errorMessageSaving)
        }
    }
    
    func onAppear() {
        self.loading = true
        numberCars { [weak self] in
            self?.numberMoticicles()
        }
    }
    
    func numberMoticicles() {
        self.loading = true
        registerMotocicleService.retrieveAll()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                debugPrint(error.localizedDescription)
                self?.loading = false
            }, receiveValue: { [weak self] response in
               // self?.state.numersOfMotocicles = response
                self?.loading = false
                self?.objectWillChange.send()
            })
            .store(in: &self.subscribers)
    }
    
    func numberCars(completion: @escaping () -> Void) {
        registerCarService.retrieveAll()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                debugPrint(error.localizedDescription)
                self?.loading = false
            }, receiveValue: { [weak self] response in
                //self?.state.numersOfCars = response
                self?.loading = false
                completion()
            })
            .store(in: &subscribers)
    }
    
    func onDisappear() {
        state.numersOfCars = 0
        state.inputPlaque = ""
        state.inputCylinderCapacity = ""
        state.showAlert = false
    }
}
