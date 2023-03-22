//
//  CoreDataManagerProtocol.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import Combine
import Domain

public protocol CoreDataManagerProtocol {
    func save(with data: Domain.Vehicle) -> Future<Bool, Error>
    func retrieveObjects() -> Future<[Domain.Vehicle], Error>
    func retrieveObject(numerPlaque: String) -> Future<Domain.Vehicle?, Error>
    func delete(numerPlaque: String) -> Future<Bool, Error>
}
