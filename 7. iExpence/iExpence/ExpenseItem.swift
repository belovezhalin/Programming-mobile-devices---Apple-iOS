//
//  ExpenceItem.swift
//  iExpence
//
//  Created by belovezhalin on 09/02/2025.
//

import Foundation
import SwiftData

@Model
class ExpenseItem {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
