//
//  RealmManager.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 3/04/23.
//

import Foundation
import Combine
@_implementationOnly import RealmSwift

class RealmManager {
    var realm: Realm?
    
    init() {
        realm = try? Realm()
    }
}

// MARK: Create here the CRUD
extension RealmManager: RealmManagerProtocol {
    internal func save<T: Object>(dto: T) -> AnyPublisher<Bool, Error> {
        return Future { [weak self] promise in
            do {
                try self?.realm?.write { self?.realm?.add(dto) }
                debugPrint("Realm saved data")
                promise(.success(true))
            } catch let error as NSError {
                debugPrint("Realm has error whent try to save data")
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    internal func fetchObjects<T: Object>(_ type: T.Type) -> AnyPublisher<[T], Never> {
        let results = realm?.objects(type)
        var data: [T] = []
        results?.forEach { item in
            data.append(item)
        }
        return Just(data)
            .eraseToAnyPublisher()
    }
    
    internal func fetchObject<T: Object>(plaqueId: String, _ type: T.Type) -> AnyPublisher<T?, Never> {
        let predicate = NSPredicate(format: "plaqueId=%@", plaqueId)
        let data = realm?.objects(type).filter(predicate).first
        return Just(data)
            .eraseToAnyPublisher()
    }
    
    internal func delete<T: Object>(plaqueId: String, _ type: T.Type) -> AnyPublisher<Bool, Error> {
        return Future { [weak self] promise in
            do {
                try self?.realm?.write {
                    let predicate = NSPredicate(format: "plaqueId=%@", plaqueId)
                    let data = self?.realm?.objects(type).filter(predicate).first
                    if let object = data {
                        self?.realm?.delete(object)
                        promise(.success(true))
                    }
                    promise(.success(false))
                }
            } catch {
                debugPrint("Realm has error whent try to save data")
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
