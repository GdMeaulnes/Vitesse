//
//  LoginView.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 22/12/2025.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var sessionManager: SessionManager
    @StateObject private var viewModel: LoginViewModel
    
    @State private var showRegisterSuccess = false
    @State private var registerSuccessMessage = "Compte créé avec succès"
    
    init(sessionManager: SessionManager) {
        _viewModel = StateObject(
            wrappedValue: LoginViewModel(sessionManager: sessionManager,
                                         logUserUseCase: LogUserUseCase())
        )
    }
    
    @State private var goToRegister = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image("VitesseLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .padding(.bottom, 30)
                
                VStack(spacing: 50) {
                    
                    Text("Login")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 15) {
                        AuthTextFieldView(
                            systemImage: "envelope",
                            placeholder: "Email",
                            text: $viewModel.credential.email,
                            isSecure: false,
                            isValueVisible: .constant(false)
                        )
                        
                        AuthTextFieldView(
                            systemImage: "lock",
                            placeholder: "Password",
                            text: $viewModel.credential.password,
                            isSecure: true,
                            isValueVisible: $viewModel.isPasswordVisible
                        )
                    }
                    
                    if showRegisterSuccess {
                        Text(registerSuccessMessage)
                            .foregroundColor(.green)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                    }
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                    }
                    
                    VStack(spacing: 15) {
                        
                        Button {
                            Task {
                                let success = await viewModel.signIn()
                                if success {
                                    await MainActor.run {
                                    }
                                }
                            }
                        } label: {
                            if viewModel.isLoading {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                            } else {
                                Text("Sign in")
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .disabled(!viewModel.isFormValid || viewModel.isLoading)
                        
                        Button {
                            goToRegister = true
                        } label: {
                            Text("Register")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                    }
                    .frame(maxWidth: 340)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(radius: 10)
                    )
                    
                    Spacer()
                }
                .padding()
                .background(Color(.systemGroupedBackground))
            }
            .navigationDestination(isPresented: $goToRegister) {
                RegisterView()
                    .onDisappear {
                        // viewModel.resetForm()
                        showRegisterSuccess = true
                    }
                }
            }
        }
    
}


#Preview {
    RootView()
        .environmentObject(SessionManager())
}
