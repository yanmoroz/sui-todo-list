//
//  ActiveTodoListSection.swift
//  TodoListSUI
//
//  Created by Yan Moroz on 01.02.2024.
//

import SwiftUI
import SwiftData

struct ActiveTodoListSection: View {
    
    @Query(filter: #Predicate<Todo> { !$0.isCompleted },
           sort: [SortDescriptor(\Todo.lastUpdated, order: .reverse)],
           animation: .snappy)
    private var activeList: [Todo]
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        Section(activeSectionTitle) {
            ForEach(activeList) { todo in
                TodoRowView(todo: todo)
            }
        }
    }
    
    var activeSectionTitle: String {
        let count = activeList.count
        return count == 0 ? "Active" : "Active \(count)"
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Todo.self, configurations: config)
    Todo.mockObjects.forEach { container.mainContext.insert($0) }
    
    return ActiveTodoListSection()
        .modelContainer(container)
}
