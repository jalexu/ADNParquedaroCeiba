//
//  ConfigurationCoreDataBase.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import Foundation
import CoreData

final class ConfigurationCoreDataBase {
    static var contexts = persistentContainer.viewContext
    
    static var context: NSManagedObjectContext {
        return contexts
    }
    
    // MARK: Find CoreData
    static var objectModel: NSManagedObjectModel = {
        let messageKitBundle = Bundle(identifier: "com.jaime.uribe.Infraestructure")
        guard let modelURL = messageKitBundle!.url(forResource: "RegisterVehiclesDB", withExtension: "momd")else {
            preconditionFailure("No found database")
        }
        
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    // MARK: - CoreData stack
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RegisterVehiclesDB", managedObjectModel: objectModel)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - CoreData Saving support
    static func saveContext() {
       
        if contexts.hasChanges {
            do {
                try contexts.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
