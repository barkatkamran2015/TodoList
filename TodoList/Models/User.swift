//
//  User.swift
//  TodoList
//
//  Created by Barkat Ali Kamran on 2025-02-12.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
    
    func asDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "email": email,
            "joined": joined
        ]
    }
}
