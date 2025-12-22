//
//  LogUser.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 22/12/2025.
//
import Foundation

class LogUserUseCase {
    
    let userRepository = UserRepository()
    
    func execute(credentials: Credentials) async throws ->  LoggedInUser {
        
        return try await userRepository.login(credentials: credentials)
    }
    
}
