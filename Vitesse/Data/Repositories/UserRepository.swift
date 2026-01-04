//
//  UserRepository.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 22/12/2025.
//

import Foundation

// Communication entre Entités et DTOs pour les utilisateurs
class UserRepository {
    
    let userDTO = UserAPIDataSource()
    
    func registerNewUser(user: User) async throws -> Bool {
        
        do {
            let newUserDTO = UserMapper.map2DTO(user: user)
            return try await userDTO.postNewUser(newUser: newUserDTO)
        }
        catch {
            throw error
        }
        
    }
    
    func login(credentials: Credentials) async throws -> LoggedInUser  {
        do {
            let idDTO = UserMapper.map2IdDTO(credentials: credentials)
            let token = try await userDTO.login(client: idDTO)
            let loggedUser = UserMapper.map2LoggedInUser(token: token)
            return loggedUser
        }
        catch {
            throw error
        }
    }
}
