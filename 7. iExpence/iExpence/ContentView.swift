//
//  ContentView.swift
//  iExpence
//
//  Created by belovezhalin on 11/12/2024.
//

//PROJECT 12 - SWIFTDATA

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var expenses: [ExpenseItem] = []
    @State private var showingAddExpense = false
    
    @State private var sortOrder = SortOrder.amount
    @State private var filterType = "All"
    
    let sortOptions = ["Name", "Amount"]
    let filterOptions = ["All", "Personal", "Business"]

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Picker("Sort by", selection: $sortOrder) {
                        Text("Name").tag(SortOrder.name)
                        Text("Amount").tag(SortOrder.amount)
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: sortOrder) { updateSorting() }

                    Picker("Filter", selection: $filterType) {
                        ForEach(filterOptions, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.menu)
                    .onChange(of: filterType) { updateSorting() }
                }
                .padding()

                List {
                    ForEach(expenses) { item in
                        expenseRow(for: item)
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .onAppear(perform: updateSorting)
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView()
        }
    }

    @ViewBuilder
    func expenseRow(for item: ExpenseItem) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(item.amount, format: .currency(code: "PLN"))
                .style(for: item.amount)
        }
    }

    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(expenses[index])
        }
        updateSorting()
    }

    func updateSorting() {
        var allExpenses = try? modelContext.fetch(FetchDescriptor<ExpenseItem>())
        
        if filterType == "Personal" {
            allExpenses = allExpenses?.filter { $0.type == "Personal" }
        } else if filterType == "Business" {
            allExpenses = allExpenses?.filter { $0.type == "Business" }
        }
        
        if sortOrder == .name {
            expenses = allExpenses?.sorted { $0.name < $1.name } ?? []
        } else {
            expenses = allExpenses?.sorted { $0.amount < $1.amount } ?? []
        }
    }
}

enum SortOrder {
    case name, amount
}

// PROJECT 7 - USERDEFAULTS WITH CODABLE
/*
import SwiftUI
import Observation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false

    var personalExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }
    
    var businessExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }
    
    func removeItems(at offsets: IndexSet, from category: String) {
        let allItems = category == "Personal" ? personalExpenses : businessExpenses
        
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: { $0.id == allItems[offset].id }) {
                expenses.items.remove(at: index)
            }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Personal Expenses")) {
                    ForEach(personalExpenses) { item in
                        expenseRow(for: item)
                    }
                    .onDelete { offsets in removeItems(at: offsets, from: "Personal") }
                }

                Section(header: Text("Business Expenses")) {
                    ForEach(businessExpenses) { item in
                        expenseRow(for: item)
                    }
                    .onDelete { offsets in removeItems(at: offsets, from: "Business") }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    @ViewBuilder
    func expenseRow(for item: ExpenseItem) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
                    .foregroundColor(.secondary)
            }

            Spacer()
            Text(item.amount, format: .currency(code: "PLN"))
                .style(for: item.amount)
        }
    }
}
*/
extension View {
    func style(for amount: Double) -> some View {
        if amount < 10 {
            return AnyView(self.foregroundColor(.green))
        } else if amount < 100 {
            return AnyView(self.foregroundColor(.blue))
        } else {
            return AnyView(self.foregroundColor(.red).bold())
        }
    }
}

#Preview {
    ContentView()
}
