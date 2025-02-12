//
//  DataCoreProjectApp.swift
//  DataCoreProject
//
//  Created by Angelina on 09/02/2025.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
