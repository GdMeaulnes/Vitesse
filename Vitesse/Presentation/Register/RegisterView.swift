//
//  RegisterView.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 23/12/2025.
//
import SwiftUI

struct RegisterView: View {
    
    @StateObject private var viewModel = RegisterViewModel()
    
    @State private var confirmPassword = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("VitesseLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .padding(.bottom, 30)
            
            VStack(spacing: 40) {
                
                Text("Register")
                    .font(.title)
                    .fontWeight(.semibold)
                
                VStack(spacing: 15) {
                    AuthTextFieldView(
                        systemImage: "person",
                        placeholder: "First Name",
                        text: $viewModel.newUser.firstName,
                        isSecure: false,
                        isValueVisible: .constant(false)
                    )
                    
                    AuthTextFieldView(
                        systemImage: "person",
                        placeholder: "Last Name",
                        text: $viewModel.newUser.lastName,
                        isSecure: false,
                        isValueVisible: .constant(false)
                    )
                    
                    AuthTextFieldView(
                        systemImage: "envelope",
                        placeholder: "Email",
                        text: $viewModel.newUser.email,
                        isSecure: false,
                        isValueVisible: .constant(false)
                    )
                    
                    AuthTextFieldView(
                        systemImage: "lock",
                        placeholder: "Password",
                        text: $viewModel.newUser.password,
                        isSecure: true,
                        isValueVisible: $viewModel.isPasswordVisible
                    )
                    
                    AuthTextFieldView(
                        systemImage: "lock",
                        placeholder: "Confirm Password",
                        text: $confirmPassword,
                        isSecure: true,
                        isValueVisible: $viewModel.isPasswordVisible
                    )
                }
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }
                
                Button {
                    Task {
                        await viewModel.toRegister(newUser: viewModel.newUser)
                    }
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("Create")
                            .frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .disabled(!viewModel.isFormValid || viewModel.isLoading)
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
}

#Preview {
    RegisterView()
}
