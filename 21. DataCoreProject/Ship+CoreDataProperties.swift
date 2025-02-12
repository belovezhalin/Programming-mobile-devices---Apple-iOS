//
//  Ship+CoreDataProperties.swift
//  DataCoreProject
//
//  Created by Angelina on 09/02/2025.
//
//

import Foundation
import CoreData


extension Ship {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ship> {
        return NSFetchRequest<Ship>(entityName: "Ship")
    }

    @NSManaged public var name: String?
    @NSManaged public var universe: String?

}

extension Ship : Identifiable {

}
