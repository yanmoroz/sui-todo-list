//
//  Todo.swift
//  TodoListSUI
//
//  Created by Yan Moroz on 01.02.2024.
//

import SwiftUI
import SwiftData

@Model
class Todo {
    
    private(set) var taskID: String = UUID().uuidString
    var task: String
    var isCompleted: Bool = false
    var priority: Priority = Priority.normal
    var lastUpdated: Date = Date.now
    
    init(task: String, priority: Priority) {
        self.task = task
        self.priority = priority
    }
    
    init(task: String, priority: Priority, isCompleted: Bool) {
        self.task = task
        self.priority = priority
        self.isCompleted = isCompleted
    }
}

enum Priority: String, Codable, CaseIterable {
    
    case normal = "Normal"
    case medium = "Medium"
    case high = "High"
    
    var color: Color {
        switch self {
        case .normal: return .green
        case .medium: return .yellow
        case .high: return .red
        }
    }
}

extension Todo {
    static var mockObjects: [Todo] {
        return [
            Todo(task: "Task Description 1", priority: .high),
            Todo(task: "Task Description 2", priority: .medium),
            Todo(task: "Task Description 3", priority: .normal),
            Todo(task: "Task Description 4", priority: .high, isCompleted: true),
            Todo(task: "Task Description 5", priority: .medium, isCompleted: true),
            Todo(task: "Task Description 6", priority: .normal, isCompleted: true)
        ]
    }
}
