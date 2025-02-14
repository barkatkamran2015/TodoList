//
//  ProfileViewViewModel.swift
//  TodoList
//
//  Created by Barkat Ali Kamran on 2025-02-12.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewViewModel: ObservableObject {
    init() {}
    @Published var user: User? = nil
    @Published var isLoggedOut = false
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }

        let db = Firestore.firestore()
        db.collection("user").document(userId).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }

            DispatchQueue.main.async {
                self?.user = User(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0
                )
            }
        }
    }

    
    func logOut() {
            do {
                try Auth.auth().signOut()
                DispatchQueue.main.async {
                    self.user = nil
                    self.isLoggedOut = true // Set logout status
                }
            } catch {
                print("Logout error: \(error.localizedDescription)")
            }
        }

}
