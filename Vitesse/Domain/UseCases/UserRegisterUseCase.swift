//
//  UserRegisterUseCase.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 22/12/2025.
//

import Foundation

class UserRegisterUseCase {
    
    let userRepository = UserRepository()
    
    func execute(user: User) async throws-> Bool {
        
        return try await userRepository.registerNewUser(user: user)
    }
    
}
