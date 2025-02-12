//
//  DataController.swift
//  DataCoreProject
//
//  Created by Angelina on 09/02/2025.
//

import CoreData

class DataController: ObservableObject {
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "CoreDataProject")

        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }

            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
