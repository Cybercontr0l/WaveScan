//
//  ScanSessionEntity+CoreDataProperties.swift
//  
//
//  Created by Dil Kamila on 13.02.2025.
//
//

import Foundation
import CoreData


extension ScanSessionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScanSessionEntity> {
        return NSFetchRequest<ScanSessionEntity>(entityName: "ScanSessionEntity")
    }

    @NSManaged public var bluetoothDevices: Data?
    @NSManaged public var lanDevices: Data?
    @NSManaged public var timestamp: Date?

}
