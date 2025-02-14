//
//  LANEntity+CoreDataProperties.swift
//  
//
//  Created by Dil Kamila on 13.02.2025.
//
//

import Foundation
import CoreData


extension LANEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LANEntity> {
        return NSFetchRequest<LANEntity>(entityName: "LANEntity")
    }

    @NSManaged public var ip: String?
    @NSManaged public var mac: String?
    @NSManaged public var name: String?
    @NSManaged public var timestamp: Date?

}
