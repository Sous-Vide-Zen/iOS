//
//  User.swift
//  Sous-Vide-Zen
//
//  Created by Aleksandr Garipov on 02.12.2023.
//

import Foundation

struct User: Codable {
    let username: String
    let email: String
    let password: String
}

struct UserResponse: Codable {
    let username: String
    let email: String
    let id: Int
}
