//
//  User.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 20/12/2025.
//

import Foundation

// Structure "Métier" de l'App pour les utilisateurs
struct User {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
}

struct Credentials: Encodable {
    var email: String
    var password: String
}

struct LoggedInUser {
    let accessToken: String
    let isAdmin: Bool
}
