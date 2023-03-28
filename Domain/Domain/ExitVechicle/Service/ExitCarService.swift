//
//  ExitCarService.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 27/03/23.
//

import Foundation
import Combine

public protocol ExitCarServiceProtocol {
    func retrieveExitCar(numerPlaque: String) -> AnyPublisher<ExitCar?, Error>
    func deleteCar(numerPlaque: String) -> AnyPublisher<Bool, Error>
}

public class ExitCarService: ExitCarServiceProtocol {
    private let exitCarRepository: ExitCarRepositoryProtocol
    
    public init(exitCarRepository: ExitCarRepositoryProtocol) {
        self.exitCarRepository = exitCarRepository
    }
    
    public func retrieveExitCar(numerPlaque: String) -> AnyPublisher<ExitCar?, Error> {
        exitCarRepository.retrieveExitCar(numerPlaque: numerPlaque)
    }
    
    public func deleteCar(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        exitCarRepository.deleteCar(numerPlaque: numerPlaque)
    }
}
