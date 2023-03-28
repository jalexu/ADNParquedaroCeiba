//
//  CarEntity+CoreDataProperties.swift
//  Infraestructure
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 24/03/23.
//
//

import Foundation
import CoreData


extension CarEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarEntity> {
        return NSFetchRequest<CarEntity>(entityName: "CarEntity")
    }

    @NSManaged public var plaqueId: String?
    @NSManaged public var resgisterCar: RegisterCarEntity?

}

extension CarEntity : Identifiable {

}
