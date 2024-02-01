//
//  CompletedTodoListSection.swift
//  TodoListSUI
//
//  Created by Yan Moroz on 01.02.2024.
//

import SwiftUI
import SwiftData

struct CompletedTodoListSection: View {
    
    @Query private var completedList: [Todo]
    @Binding var showAll: Bool
    
    private let fetchLimit = 5
    
    init(showAll: Binding<Bool>) {
        let predicate = #Predicate<Todo> { $0.isCompleted }
        let sort = [SortDescriptor(\Todo.lastUpdated, order: .reverse)]
        var descriptor = FetchDescriptor(predicate: predicate, sortBy: sort)
        
        if !showAll.wrappedValue {
            descriptor.fetchLimit = fetchLimit
        }
        
        _completedList = Query(descriptor, animation: .snappy)
        _showAll = showAll
    }
    
    var body: some View {
        Section {
            ForEach(completedList) {
                TodoRowView(todo: $0)
            }
        } header: {
            HStack {
                Text("Completed")
                
                Spacer(minLength: 0)
                
                if showAll && !completedList.isEmpty {
                    Button("Show Recent") {
                        showAll = false
                    }
                }
            }
        } footer: {
            if completedList.count == fetchLimit && !showAll && !completedList.isEmpty {
                HStack {
                    Text("Showing Recent 15 Tasks")
                        .foregroundStyle(.gray)
                    
                    Button("Show All") {
                        showAll = true
                    }
                }
                .font(.caption)
            } else {
                
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Todo.self, configurations: config)
    Todo.mockObjects.forEach { container.mainContext.insert($0) }
    
    return Group {
        Spacer()
        
        CompletedTodoListSection(showAll: .constant(false))
            .modelContainer(container)
        
        Spacer()
        
        CompletedTodoListSection(showAll: .constant(true))
            .modelContainer(container)
        
        Spacer()
    }
}
