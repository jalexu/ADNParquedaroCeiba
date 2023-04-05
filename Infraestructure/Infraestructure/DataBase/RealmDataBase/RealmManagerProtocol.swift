//
//  RealmManagerProtocol.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 5/04/23.
//

import Combine
@_implementationOnly import RealmSwift

protocol RealmManagerProtocol {
    func save<T: Object>(dto: T) -> AnyPublisher<Bool, Error>
    func fetchObjects<T: Object>(_ type: T.Type) -> AnyPublisher<[T], Never>
    func fetchObject<T: Object>(plaqueId: String, _ type: T.Type) -> AnyPublisher<T?, Never>
    func delete<T: Object>(plaqueId: String, _ type: T.Type) -> AnyPublisher<Bool, Error>
}
