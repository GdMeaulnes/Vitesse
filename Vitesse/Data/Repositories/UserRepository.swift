//
//  UserRepository.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 22/12/2025.
//

import Foundation

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
    
    func login(credentials: Credentials) async throws -> TokenDTO  {
        do {
            let client = UserMapper.map2IdDO(credentials: credentials)
            return try await userDTO.login(client: client)
        }
    }
}
