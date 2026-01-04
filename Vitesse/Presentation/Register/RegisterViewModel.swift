//
//  RegisterViewModel.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 23/12/2025.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class RegisterViewModel: ObservableObject {
    
    let userRegisterUseCase = UserRegisterUseCase()
    
    @Published var newUser = User(email: "", password: "", firstName: "", lastName: "")
    
    @Published var isLoading: Bool = false
    @Published var isPasswordVisible: Bool = false
    @Published var errorMessage: String?
    
    @Published var confirmPassword = ""

    var passwordsMatch: Bool {
        !confirmPassword.isEmpty && newUser.password == confirmPassword
    }
    
    var isFormValid: Bool {
        !newUser.email.isEmpty &&
        !newUser.firstName.isEmpty &&
        !newUser.lastName.isEmpty &&
        !newUser.password.isEmpty &&
        passwordsMatch
    }
    
    var passwordError: String? {
        guard !confirmPassword.isEmpty else { return nil }
        return (newUser.password == confirmPassword) ? nil : "Passwords do not match"
    }
    
    func validatePasswords() {
        if !confirmPassword.isEmpty &&
           newUser.password != confirmPassword {
            errorMessage = "Passwords do not match"
        } else {
            errorMessage = nil
        }
    }
    
    func toRegister(newUser: User) async {
        do {
            isLoading = true
            _ = try await userRegisterUseCase.execute(user: newUser)
            errorMessage = nil
        } catch {
            self.errorMessage = "Error during registration"
        }
        isLoading = false
    }
}

