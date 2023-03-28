//
//  RegisterMotocicleEntity+CoreDataProperties.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//
//

import Foundation
import CoreData


extension RegisterMotocicleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RegisterMotocicleEntity> {
        return NSFetchRequest<RegisterMotocicleEntity>(entityName: "RegisterMotocicleEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var registerDay: Date?
    @NSManaged public var plaqueId: String?
    @NSManaged public var motocicles: NSSet?

}

// MARK: Generated accessors for motocicles
extension RegisterMotocicleEntity {

    @objc(addMotociclesObject:)
    @NSManaged public func addToMotocicles(_ value: MotocicleEntity)

    @objc(removeMotociclesObject:)
    @NSManaged public func removeFromMotocicles(_ value: MotocicleEntity)

    @objc(addMotocicles:)
    @NSManaged public func addToMotocicles(_ values: NSSet)

    @objc(removeMotocicles:)
    @NSManaged public func removeFromMotocicles(_ values: NSSet)

}

extension RegisterMotocicleEntity : Identifiable {

}
