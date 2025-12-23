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
    
    var isFormValid: Bool {
        !newUser.email.isEmpty && !newUser.firstName.isEmpty && !newUser.lastName.isEmpty && !newUser.password.isEmpty
    }
}
