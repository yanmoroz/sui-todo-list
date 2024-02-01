//
//  HomeView.swift
//  TodoListSUI
//
//  Created by Yan Moroz on 01.02.2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State private var showAll = false
    @Environment(\.modelContext) private var context
    
    var body: some View {
        List {
            ActiveTodoListSection()
            CompletedTodoListSection(showAll: $showAll)
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    let todo = Todo(task: "", priority: .normal)
                    context.insert(todo)
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 42))
                        .fontWeight(.light)
                })
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Todo.self, configurations: config)
    Todo.mockObjects.forEach { container.mainContext.insert($0) }
    
    return HomeView()
        .modelContainer(container)
}
