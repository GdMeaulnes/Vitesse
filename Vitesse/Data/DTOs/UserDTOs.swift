//
//  UserDTOs.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 16/12/2025.
//

import Foundation

struct UserDTOs: Codable {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
}

let sampleUser1: UserDTOs = .init(
    email : "user1@vitesse.com",
    password : "user1",
    firstName : "User1Firstname",
    lastName : "User1Lastname"
)


