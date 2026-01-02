//
//  LoginViewModel.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 22/12/2025.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class LoginViewModel: ObservableObject {

    @Published var credential = Credentials(email: "", password: "")
    @Published var currentUser = LoggedInUser(accessToken: "", isAdmin: false)

    @Published var isLoading: Bool = false
    @Published var isPasswordVisible: Bool = false
    @Published var errorMessage: String?
    
    private let sessionManager: SessionManager
    init(
        sessionManager: SessionManager,
    ) {
        self.sessionManager = sessionManager
    }
    
    let logUserUseCase = LogUserUseCase()
    

    var isFormValid: Bool {
        !credential.email.isEmpty && !credential.password.isEmpty
    }

    func signIn() async -> Bool {
        isLoading = true
        defer { isLoading = false }
        
        do {
            currentUser = try await logUserUseCase.execute(credentials: credential)
            errorMessage = nil
            sessionManager.startSession(accessToken: currentUser.accessToken, isAdmin: currentUser.isAdmin)
            
            return true
        } catch {
            self.errorMessage = "Logging Error"
            return false
        }
    }

    func register() {
        print("Navigate to register")
    }
}
