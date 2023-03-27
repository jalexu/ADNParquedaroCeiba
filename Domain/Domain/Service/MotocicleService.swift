//
//  MotocicleService.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import Combine

public protocol MotocicleServiceProtocol {
    func saveMotocicle(with data: RegisterMotocicle) -> AnyPublisher<Bool, Error>
    func retrieveMotocicleObjects() -> AnyPublisher<Int, Error>
    func retrieveMotocicleObject(numerPlaque: String) -> AnyPublisher<ExitMotocicle?, Error>
    func deleteMotocicle(numerPlaque: String) -> AnyPublisher<Bool, Error>
}

public class MotocicleService: MotocicleServiceProtocol {
    private let motocicleRepository: MotocicleRepository
    
    public init(motocicleRepository: MotocicleRepository) {
        self.motocicleRepository = motocicleRepository
    }
    
    public func saveMotocicle(with data: RegisterMotocicle) -> AnyPublisher<Bool, Error> {
        motocicleRepository.saveMotocicle(with: data)
    }
    
    public func retrieveMotocicleObjects() -> AnyPublisher<Int, Error> {
        motocicleRepository.retrieveMotocicleObjects()
    }
    
    public func retrieveMotocicleObject(numerPlaque: String) -> AnyPublisher<ExitMotocicle?, Error> {
        motocicleRepository.retrieveMotocicleObject(numerPlaque: numerPlaque)
    }
    
    public func deleteMotocicle(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        motocicleRepository.deleteMotocicle(numerPlaque: numerPlaque)
    }
}
