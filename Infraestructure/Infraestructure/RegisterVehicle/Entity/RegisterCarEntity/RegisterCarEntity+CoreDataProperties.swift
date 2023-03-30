//
//  RegisterCarEntity+CoreDataProperties.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//
//

import Foundation
import CoreData


extension RegisterCarEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RegisterCarEntity> {
        return NSFetchRequest<RegisterCarEntity>(entityName: "RegisterCarEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var registerDay: Date?
    @NSManaged public var plaqueId: String?
    @NSManaged public var cars: NSSet?

}

// MARK: Generated accessors for cars
extension RegisterCarEntity {

    @objc(addCarsObject:)
    @NSManaged public func addToCars(_ value: CarEntity)

    @objc(removeCarsObject:)
    @NSManaged public func removeFromCars(_ value: CarEntity)

    @objc(addCars:)
    @NSManaged public func addToCars(_ values: NSSet)

    @objc(removeCars:)
    @NSManaged public func removeFromCars(_ values: NSSet)

}

extension RegisterCarEntity : Identifiable {

}
