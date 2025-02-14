//
//  Item+CoreDataProperties.swift
//  
//
//  Created by Dil Kamila on 13.02.2025.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var timestamp: Date?

}
