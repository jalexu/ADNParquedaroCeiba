//
//  ExitCarService.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 27/03/23.
//

import Foundation
import Combine

public protocol ExitVehicleServiceProtocol {
    func retrieveExitVehicle(numerPlaque: String) -> AnyPublisher<ExitVehicle?, Error>
    func deleteRegister(numerPlaque: String) -> AnyPublisher<Bool, Error>
}

public class ExitVehicleService: ExitVehicleServiceProtocol {
    private let exitVehicleRepository: ExitVehicleRepositoryProtocol
    
    public init(exitVehicleRepository: ExitVehicleRepositoryProtocol) {
        self.exitVehicleRepository = exitVehicleRepository
    }
    
    public func retrieveExitVehicle(numerPlaque: String) -> AnyPublisher<ExitVehicle?, Error> {
        exitVehicleRepository.retrieveExitVehicle(numerPlaque: numerPlaque)
    }
    
    public func deleteRegister(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        exitVehicleRepository.deleteRegister(numerPlaque: numerPlaque)
    }
}
