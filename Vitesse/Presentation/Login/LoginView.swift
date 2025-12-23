//
//  LoginView.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 22/12/2025.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
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
                    AuthTextField(
                        systemImage: "envelope",
                        placeholder: "Email",
                        text: $viewModel.credential.email,
                        isSecure: false,
                        isPasswordVisible: .constant(false)
                    )

                    AuthTextField(
                        systemImage: "lock",
                        placeholder: "Password",
                        text: $viewModel.credential.password,
                        isSecure: true,
                        isPasswordVisible: $viewModel.isPasswordVisible
                    )
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }

                // Les boutons
                VStack(spacing: 15) {

                    Button {
                        Task {
                            await viewModel.signIn()
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
                        print("Vers register")
                    } label: {
                        Text("Register")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                }
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
    

    // Développement des raccourcis pour les fonctions
//    private func signIn() async {
//        do {
//            viewModel.isLoading = true
//            viewModel.currentUser = try await logUserUseCase.execute(credentials: viewModel.credential)
//            viewModel.errorMessage = nil
//        } catch {
//            viewModel.errorMessage = error.localizedDescription
//        }
//        viewModel.isLoading = false
//    }
    
}


#Preview {
    LoginView()
}
