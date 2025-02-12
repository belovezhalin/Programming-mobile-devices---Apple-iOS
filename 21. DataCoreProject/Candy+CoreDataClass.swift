//
//  Candy+CoreDataClass.swift
//  DataCoreProject
//
//  Created by Angelina on 10/02/2025.
//
//

import Foundation
import CoreData

@objc(Candy)
public class Candy: NSManagedObject {
    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
}
