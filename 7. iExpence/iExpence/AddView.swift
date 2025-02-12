//
//  AddView.swift
//  iExpence
//
//  Created by belovezhalin on 18/12/2024.
//

//PROJECT 12 - SWIFTDATA

 import SwiftUI
 import SwiftData

 struct AddView: View {
     @Environment(\.dismiss) var dismiss
     @Environment(\.modelContext) private var modelContext

     @State private var name = ""
     @State private var type = "Personal"
     @State private var amount = 0.0

     let types = ["Business", "Personal"]

     var body: some View {
         NavigationStack {
             Form {
                 TextField("Name", text: $name)

                 Picker("Type", selection: $type) {
                     ForEach(types, id: \.self) { Text($0) }
                 }

                 TextField("Amount", value: $amount, format: .currency(code: "PLN"))
                     .keyboardType(.decimalPad)
             }
             .navigationTitle("Add new expense")
             .toolbar {
                 Button("Save") {
                     let newItem = ExpenseItem(name: name, type: type, amount: amount)
                     modelContext.insert(newItem)
                     dismiss()
                 }
             }
         }
     }
 }

#Preview {
    AddView()
}
 

//PROJECT 7 - USERDEFAULTS WITH CODABLE

/*
import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @Environment(\.dismiss) var dismiss

    var expenses: Expenses
    
    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: "PLN"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
*/
