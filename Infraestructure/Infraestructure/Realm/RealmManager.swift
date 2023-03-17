//
//  RealmManager.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 17/03/23.
//

import Foundation
@_implementationOnly import RealmSwift

protocol RealmManagerProtocol {
    func save<T: Object>(model: T)
    func fetchObject<T: Object>(numberOfPlaque: String, _ type: T) -> T?
    func delete<T: Object>(_ type: T.Type)
}

class RealmManager {
    private var realm: Realm?
    
    init() {
        self.realm = try? Realm()
    }
}

extension RealmManager: RealmManagerProtocol {
    func save<T: Object>(model: T) {
        try? realm?.write {
            realm?.add(model)
        }
    }
    
    func fetchObject<T: Object>(numberOfPlaque: String, _ type: T) -> T? {
        return realm?.objects(T.self).filter("plaqueId == %@", numberOfPlaque).first
    }
    
    func delete<T: Object>(_ type: T.Type) {
        try? realm?.write {
            if let object = realm?.objects(type) {
                realm?.delete(object)
            }
        }
    }
}
