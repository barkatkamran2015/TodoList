//
//  NewItemViewViewModel.swift
//  TodoList
//
//  Created by Barkat Ali Kamran on 2025-02-12.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class NewItemViewViewModel: ObservableObject {
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    
    init() {}
    
    func save() {
        guard canSave else {
            return
        }
        // Get current user ID
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        // Create model
        let newId = UUID().uuidString
        let newItem = TodoListItem(
            id: newId,
            title: title,
            dueDate: dueDate.timeIntervalSince1970,
            createDate: Date().timeIntervalSince1970,
            isDone: false
        )
        
        // Save model
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(newId)
            .setData(newItem.asDictionary()) { error in
                if let error = error {
                    print("Error saving document: \(error)")
                    self.showAlert = true
                } else {
                    print("Document successfully saved.")
                }
            }
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
    }
}
