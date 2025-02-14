//
//  TodoListItemViewViewModel.swift
//  TodoList
//
//  Created by Barkat Ali Kamran on 2025-02-12.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// viewModel for single todo list
class TodoListItemViewViewModel: ObservableObject {
    init() {}
    
    func toggleIsDone(item: TodoListItem) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
                return
    }
    let db = Firestore.firestore()
    db.collection("users")
        .document(uid)
        .collection("todos")
        .document(itemCopy.id)
        .setData(itemCopy.asDictionary())
}
}
