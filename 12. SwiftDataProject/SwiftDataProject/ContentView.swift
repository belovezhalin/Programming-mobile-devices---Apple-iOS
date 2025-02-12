//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Angelina on 10/02/2025.
//

import SwiftData
import SwiftUI

struct EditUserView: View {
    @Bindable var user: User

    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate),
    ]
    
    func addSample() {
        let user1 = User(name: "Piper Chapman", city: "New York", joinDate: .now)
        let job1 = Job(name: "Organize sock drawer", priority: 3)
        let job2 = Job(name: "Make plans with Alex", priority: 4)

        modelContext.insert(user1)

        user1.jobs.append(job1)
        user1.jobs.append(job2)
    }
    
    var body: some View {
        NavigationStack {
            UsersView(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)
            .navigationTitle("Users")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate),
                            ])
                        
                        Text("Sort by Join Date")
                            .tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name)
                            ])
                    }
                }
                
                Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                    showingUpcomingOnly.toggle()
                }
                
                Button("Add Samples", systemImage: "plus") {
                    try? modelContext.delete(model: User.self)
                    
                    let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))

                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
