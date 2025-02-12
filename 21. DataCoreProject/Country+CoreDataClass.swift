//
//  Country+CoreDataClass.swift
//  DataCoreProject
//
//  Created by Angelina on 10/02/2025.
//
//

import Foundation
import CoreData

@objc(Country)
public class Country: NSManagedObject {
    public var wrappedShortName: String {
        shortName ?? "Unknown Country"
    }

    public var wrappedFullName: String {
        fullName ?? "Unknown Country"
    }
    
    public var candyArray: [Candy] {
        let set = candy as? Set<Candy> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}
