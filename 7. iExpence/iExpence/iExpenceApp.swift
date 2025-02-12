//
//  iExpenceApp.swift
//  iExpence
//
//  Created by belovezhalin on 11/12/2024.
//

import SwiftData
import SwiftUI

@main
struct iExpenceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
