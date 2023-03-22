//
//  CoreDataManagerProtocol.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import Combine
import Domain

public protocol CoreDataManagerProtocol {
    func save(with data: Domain.Vehicle) -> AnyPublisher<Bool, Error>
    func retrieveObjects() -> AnyPublisher<[Domain.Vehicle], Error>
    func retrieveObject(numerPlaque: String) -> AnyPublisher<Domain.Vehicle?, Error>
    func delete(numerPlaque: String) -> AnyPublisher<Bool, Error>
}
