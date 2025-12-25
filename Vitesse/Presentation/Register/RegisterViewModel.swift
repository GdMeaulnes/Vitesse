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
    
    @Published var newUser = User(email: "", password: "", firstName: "", lastName: "")
    
    @Published var isLoading: Bool = false
    @Published var isPasswordVisible: Bool = false
    @Published var errorMessage: String?
    
    
    let userRegisterUseCase = UserRegisterUseCase()
    
    // Ajouter l'égalité des 2 password
    var isFormValid: Bool {
        !newUser.email.isEmpty && !newUser.firstName.isEmpty && !newUser.lastName.isEmpty && !newUser.password.isEmpty
    }
    
    func toRegister(newUser: User) async {
        do {
            isLoading = true
            try await userRegisterUseCase.execute(user: newUser)
            errorMessage = nil
        } catch {
            self.errorMessage = "Error during registration"
        }
        isLoading = false
    }
    
}

