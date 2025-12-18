//
//  UserDTOs.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 16/12/2025.
//

import Foundation

struct UserDTOs: Codable {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
}

struct AdminDTO: Codable {
    let email: String
    let password: String

    init(
        email: String = "admin@vitesse.com",
        password: String = "test123"
    ) {
        self.email = email
        self.password = password
    }
}

struct AdminTokenDTO: Codable {
    let accessToken: String
    let isAdmin: Bool
}

let sampleUser1: UserDTOs = .init(
    email : "user1@vitesse.com",
    password : "user1",
    firstName : "User1Firstname",
    lastName : "User1Lastname"
)

