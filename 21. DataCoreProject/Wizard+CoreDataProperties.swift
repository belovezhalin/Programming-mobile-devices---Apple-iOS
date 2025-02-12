//
//  Wizard+CoreDataProperties.swift
//  DataCoreProject
//
//  Created by Angelina on 09/02/2025.
//
//

import Foundation
import CoreData


extension Wizard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wizard> {
        return NSFetchRequest<Wizard>(entityName: "Wizard")
    }

    @NSManaged public var name: String?

}

extension Wizard : Identifiable {

}
