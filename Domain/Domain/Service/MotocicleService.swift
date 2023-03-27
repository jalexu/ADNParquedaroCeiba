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
    private let motocicleService: MotocicleRepository
    
    public init(motocicleService: MotocicleRepository) {
        self.motocicleService = motocicleService
    }
    
    public func saveMotocicle(with data: RegisterMotocicle) -> AnyPublisher<Bool, Error> {
        motocicleService.saveMotocicle(with: data)
    }
    
    public func retrieveMotocicleObjects() -> AnyPublisher<Int, Error> {
        motocicleService.retrieveMotocicleObjects()
    }
    
    public func retrieveMotocicleObject(numerPlaque: String) -> AnyPublisher<ExitMotocicle?, Error> {
        motocicleService.retrieveMotocicleObject(numerPlaque: numerPlaque)
    }
    
    public func deleteMotocicle(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        motocicleService.deleteMotocicle(numerPlaque: numerPlaque)
    }
}
