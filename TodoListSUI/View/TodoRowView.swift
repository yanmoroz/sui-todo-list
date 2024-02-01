//
//  TodoRowView.swift
//  TodoListSUI
//
//  Created by Yan Moroz on 01.02.2024.
//

import SwiftUI
import SwiftData

struct TodoRowView: View {
    
    @Bindable var todo: Todo
    @FocusState private var isActive: Bool
    @Environment(\.modelContext) private var context
    
    var body: some View {
        HStack(spacing: 8) {
            if !isActive && !todo.task.isEmpty {
                Button(action: {
                    todo.isCompleted.toggle()
                    todo.lastUpdated = .now
                }, label: {
                    Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                        .padding(3)
                        .contentShape(.rect)
                        .foregroundStyle(todo.isCompleted ? .gray : .primary)
                        .contentTransition(.symbolEffect(.replace))
                })
            }
            
            TextField("Record Video", text: $todo.task)
                .strikethrough(todo.isCompleted)
                .foregroundStyle(todo.isCompleted ? .gray : .primary)
                .focused($isActive)
            
            if !isActive && !todo.task.isEmpty {
                Menu {
                    ForEach(Priority.allCases, id: \.rawValue) { priority in
                        Button {
                            todo.priority = priority
                            todo.lastUpdated = .now
                        } label: {
                            HStack {
                                Text(priority.rawValue)
                                
                                if todo.priority == priority {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                        
                    }
                } label: {
                    Image(systemName: "circle.fill")
                        .font(.title2)
                        .padding(3)
                        .contentShape(.rect)
                        .foregroundStyle(todo.priority.color.gradient)
                }
            }
        }
        .animation(.snappy, value: isActive)
        .onAppear {
            isActive = todo.task.isEmpty
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button("", systemImage: "trash") {
                context.delete(todo)
            }
            .tint(.red)
        }
        .onSubmit(of: .text) {
            if todo.task.isEmpty {
                context.delete(todo)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Todo.self, configurations: config)
    let todos = Todo.mockObjects
    todos.forEach { container.mainContext.insert($0) }
    
    return ForEach(todos) {
        TodoRowView(todo: $0)
            .modelContainer(container)
    }
}
