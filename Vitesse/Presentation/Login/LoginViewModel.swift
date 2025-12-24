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
    
    let logUserUseCase = LogUserUseCase()

    var isFormValid: Bool {
        !credential.email.isEmpty && !credential.password.isEmpty
    }

    func signIn() async {
        do {
            isLoading = true
            currentUser = try await logUserUseCase.execute(credentials: credential)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func register() {
        print("Navigate to register")
    }
}
