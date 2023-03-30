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

// MARK: save Vehicle
extension RegisterVehicleViewModel {
    private func saveVehicle(with data: RegisterVehicle, completion: @escaping () -> Void) {
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

extension RegisterVehicleViewModel: RegisterVehicleProtocol {
    func registerVehicle(completion: @escaping () -> Void) {
        var createVehicleStrategy: CreateVehicleStrategy
        var registerCar: RegisterVehicle
        let registerDay = registerDate()
        self.loading = true
        
        do {
            switch state.seletedVehicleType {
            case .car:
                createVehicleStrategy = CreateCar(plaqueId: state.inputPlaque)
                registerCar = try createVehicleStrategy.createVehicle(registerDate: registerDay)
            case .motocicle:
                createVehicleStrategy = CreateMotorcycle(plaqueId: state.inputPlaque, cylinderCapacity: state.inputPlaque)
                registerCar = try createVehicleStrategy.createVehicle(registerDate: registerDay)
            }
            
            saveVehicle(with: registerCar) {
                completion()
            }
            
        }  catch VehicleError.cylinderCapacity(let error) {
            hiddeLoading()
            showAlert(message: error)
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

    
    func onAppear() {
        numberVehicles()
    }
    
    private func numberVehicles() {
        self.loading = true
        registerCarService.retrieveAll()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                debugPrint(error.localizedDescription)
                self?.loading = false
            }, receiveValue: { [weak self] response in
                self?.showNumberVehicles(registerVehicles: response)
                self?.loading = false
            })
            .store(in: &subscribers)
    }
    
    
    private func showNumberVehicles(registerVehicles: [RegisterVehicle]) {
        updateState {
            state.numersOfMotocicles = registerVehicles.compactMap({ $0.getVehicle() as? Motorcycle}).count
            state.numersOfCars = registerVehicles.compactMap({ $0.getVehicle() as? Car}).count
        }
    }
    
    func onDisappear() {
        state.numersOfCars = 0
        state.inputPlaque = ""
        state.inputCylinderCapacity = ""
        state.showAlert = false
    }
}
