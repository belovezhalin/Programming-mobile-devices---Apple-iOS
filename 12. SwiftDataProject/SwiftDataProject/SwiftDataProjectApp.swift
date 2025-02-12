//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Angelina on 10/02/2025.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
