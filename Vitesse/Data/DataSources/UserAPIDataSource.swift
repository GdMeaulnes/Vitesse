//
//  UserAPIDataSource.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 17/12/2025.
//

import Foundation

enum UserAPIDataSourceError: Error {
    case invalidResponse
    case noDataReturned
    case decodingError
}

class UserAPIDataSource {
    
    // Description: Permet de créer un compte utilisateur dans l'API
    func postNewUser(newUser: UserDTOs) async throws -> Bool {
        
        var request = URLRequest(url: URL(string: (vaporServerAdresse + "/user/register"))!)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(newUser)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            throw UserAPIDataSourceError.invalidResponse
        }
        return true
    }
    
    // Description: Permet de s'authentifier dans l'API et de générer un token pour utliser l'API
    func loginAdmin(admin: AdminDTO) async throws -> AdminTokenDTO {
        
        var request = URLRequest(url: URL(string: (vaporServerAdresse + "/user/auth"))!)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(admin)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw UserAPIDataSourceError.invalidResponse
        }
        
        do {
            let adminToken: AdminTokenDTO = try JSONDecoder().decode(AdminTokenDTO.self, from: data)
            return adminToken
        } catch {
            throw UserAPIDataSourceError.decodingError
        }
    }
}
