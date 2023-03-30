//
//  ExitVehicleRepository.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 27/03/23.
//
import Combine

public protocol ExitVehicleRepositoryProtocol {
    func retrieveExitVehicle(numerPlaque: String) -> AnyPublisher<ExitVehicle?, Error>
    func deleteRegister(numerPlaque: String) -> AnyPublisher<Bool, Error>
}
