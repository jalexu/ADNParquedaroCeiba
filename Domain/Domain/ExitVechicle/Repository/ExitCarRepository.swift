//
//  ExitCarRepositoryProtocol.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 27/03/23.
//
import Combine

public protocol ExitCarRepositoryProtocol {
    func retrieveExitCar(numerPlaque: String) -> AnyPublisher<ExitCar?, Error>
    func deleteCar(numerPlaque: String) -> AnyPublisher<Bool, Error>
}
