//
//  TodoListApp.swift
//  TodoList
//
//  Created by Barkat Ali Kamran on 2025-02-11.
//

import SwiftUI
import FirebaseCore
@main
struct TodoListApp: App {
    init() {
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
