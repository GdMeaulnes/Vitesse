//
//  User.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 20/12/2025.
//

import Foundation

struct User {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
}

struct Credentials: Encodable {
    let email: String
    let password: String
}

struct LoggedInUser {
    let accessToken: String
    let isAdmin: Bool
}
