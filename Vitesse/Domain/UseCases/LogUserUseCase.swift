//
//  LogUser.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 22/12/2025.
//
import Foundation

//class LogUserUseCase {
//    
//    let userRepository = UserRepository()
//    
//    func execute(credentials: Credentials) async throws ->  LoggedInUser {
//        
//        return try await userRepository.login(credentials: credentials)
//    }
//    
//}


// 1️⃣ Le protocole (le contrat)
protocol LogUserUseCaseProtocol {
    func execute(credentials: Credentials) async throws -> LoggedInUser
}

// 2️⃣ L’implémentation réelle
final class LogUserUseCase {

    private let userRepository = UserRepository()

    func execute(credentials: Credentials) async throws -> LoggedInUser {
        return try await userRepository.login(credentials: credentials)
    }
}

// 3️⃣ Conformité via extension
extension LogUserUseCase: LogUserUseCaseProtocol {}
