//
//  ContentView.swift
//  TodoListSUI
//
//  Created by Yan Moroz on 01.02.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HomeView()
                .navigationTitle("Todo List")
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Todo.self, configurations: config)
    Todo.mockObjects.forEach { container.mainContext.insert($0) }
    
    return ContentView()
        .modelContainer(container)
}
