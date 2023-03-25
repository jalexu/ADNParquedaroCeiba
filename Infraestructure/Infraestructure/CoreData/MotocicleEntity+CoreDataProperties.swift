//
//  MotocicleEntity+CoreDataProperties.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//
//

import Foundation
import CoreData


extension MotocicleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MotocicleEntity> {
        return NSFetchRequest<MotocicleEntity>(entityName: "MotocicleEntity")
    }

    @NSManaged public var plaqueId: String?
    @NSManaged public var cylinderCapacity: String?
    @NSManaged public var registerMotocicle: RegisterMotocicleEntity?

}

extension MotocicleEntity : Identifiable {

}
