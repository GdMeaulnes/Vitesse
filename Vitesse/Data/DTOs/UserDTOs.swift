//
//  UserDTOs.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 16/12/2025.
//

import Foundation

enum UserAPIDataSourceError: Error {
    case invalidResponse
    case noDataReturned
    case decodingError
}

// Structure correspondant à la table 'users' de la base db.sqlite
struct UserDTO: Codable {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
}

struct TokenDTO: Codable {
    let accessToken: String
    let isAdmin: Bool
}


