//
//  ExitMotorcycleService.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 27/03/23.
//

import Foundation
import Combine

public protocol ExitMotorcycleServiceProtocol {
    func retrieveMotocycle(numerPlaque: String) -> AnyPublisher<ExitMotorcycle?, Error>
    func deleteMotorcycle(numerPlaque: String) -> AnyPublisher<Bool, Error>
}

public class ExitMotorcycleService: ExitMotorcycleServiceProtocol {
    private let exitMotocicleRepository: ExitMotocycleRepositoryProtocol
    
    public init(exitMotocicleRepository: ExitMotocycleRepositoryProtocol) {
        self.exitMotocicleRepository = exitMotocicleRepository
    }
    
    
    public func retrieveMotocycle(numerPlaque: String) -> AnyPublisher<ExitMotorcycle?, Error> {
        exitMotocicleRepository.retrieveMotocycle(numerPlaque: numerPlaque)
    }
    
    public func deleteMotorcycle(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        exitMotocicleRepository.deleteMotocycle(numerPlaque: numerPlaque)
    }
    
}
