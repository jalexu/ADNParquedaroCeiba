//
//  MotocicleService.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 23/03/23.
//

import Combine

public protocol MotocicleServiceProtocol {
    func save(with data: RegisterMotocicle) -> AnyPublisher<Bool, Error>
    func retrieveObjects() -> AnyPublisher<Int, Error>
    func retrieveObject(numerPlaque: String) -> AnyPublisher<ExitMotocicle?, Error>
    func delete(numerPlaque: String) -> AnyPublisher<Bool, Error>
}

public class MotocicleService: MotocicleServiceProtocol {
    private let motocicleService: MotocicleRepository
    
    public init(motocicleService: MotocicleRepository) {
        self.motocicleService = motocicleService
    }
    
    public func save(with data: RegisterMotocicle) -> AnyPublisher<Bool, Error> {
        motocicleService.save(with: data)
    }
    
    public func retrieveObjects() -> AnyPublisher<Int, Error> {
        motocicleService.retrieveObjects()
    }
    
    public func retrieveObject(numerPlaque: String) -> AnyPublisher<ExitMotocicle?, Error> {
        motocicleService.retrieveObject(numerPlaque: numerPlaque)
    }
    
    public func delete(numerPlaque: String) -> AnyPublisher<Bool, Error> {
        motocicleService.delete(numerPlaque: numerPlaque)
    }
}
