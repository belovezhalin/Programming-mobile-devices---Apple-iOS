//
//  FilteredList.swift
//  DataCoreProject
//
//  Created by Angelina on 09/02/2025.
//

import CoreData
import SwiftUI

enum PredicateType: String {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS"
    case endsWith = "ENDSWITH"
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    init(filterKey: String, filterValue: String, predicate: PredicateType, sortDescriptors: [SortDescriptor<T>] = [], @ViewBuilder content: @escaping (T) -> Content) {
        
        _fetchRequest = FetchRequest<T>(
            sortDescriptors: sortDescriptors,
            predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue)
        )
        
        self.content = content
    }
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            content(item)
        }
    }
}

