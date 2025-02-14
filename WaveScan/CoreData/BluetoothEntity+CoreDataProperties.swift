//
//  BluetoothEntity+CoreDataProperties.swift
//  
//
//  Created by Dil Kamila on 13.02.2025.
//
//

import Foundation
import CoreData


extension BluetoothEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BluetoothEntity> {
        return NSFetchRequest<BluetoothEntity>(entityName: "BluetoothEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var rssi: Int16
    @NSManaged public var timestamp: Date?
    @NSManaged public var uuid: String?

}
