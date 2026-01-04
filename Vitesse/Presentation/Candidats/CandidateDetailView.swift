//
//  CandidateDetailView.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 28/12/2025.
//

import SwiftUI

struct CandidateDetailView: View {
    
    @StateObject private var viewModel: CandidateDetailViewModel
    @State private var showNotAuthorizedAlert = false
    
    @EnvironmentObject private var sessionManager: SessionManager
    
    // Initialisation depuis la liste
    init(candidate: Candidate) {
        _viewModel = StateObject(
            wrappedValue: CandidateDetailViewModel(candidate: candidate)
        )
    }
    
    var body: some View {
        
        VStack {
            
            Image("VitesseLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .padding(.bottom, 30)
            
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    
                    if viewModel.isEditing {
                        
                        VStack(spacing: 8) {
                            
                            TextField(
                                "Prénom",
                                text: $viewModel.editableCandidate.firstName
                            )
                            .font(.title2)
                            .textFieldStyle(.roundedBorder)
                            
                            TextField(
                                "Nom",
                                text: $viewModel.editableCandidate.lastName
                            )
                            .font(.title2)
                            .textFieldStyle(.roundedBorder)
                        }
                        
                    } else {
                        
                        Text("\(viewModel.candidate.firstName) \(viewModel.candidate.lastName)")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                //}
                
                Spacer()
                
                Button {
                    if sessionManager.isAdmin {
                        Task {
                            await viewModel.toggleFavorite(isAdmin: true)
                        }
                    } else {
                        showNotAuthorizedAlert = true
                    }
                } label: {
                    Image(systemName: viewModel.candidate.isFavorite ? "star.fill" : "star")
                        .foregroundColor(
                            viewModel.candidate.isFavorite ? .yellow : .gray
                        )
                        .font(.system(size: 18))
                }
                .opacity(sessionManager.isAdmin ? 1.0 : 0.2)
            }
        }
        .padding()
        
        AuthTextFieldView(
            systemImage: "phone",
            placeholder: "Phone",
            text: viewModel.isEditing
            ? $viewModel.editableCandidate.phone
            : .constant(viewModel.candidate.phone),
            isSecure: false,
            isValueVisible: .constant(false)
        )
        
        AuthTextFieldView(
            systemImage: "envelope",
            placeholder: "Email",
            text: viewModel.isEditing
            ? $viewModel.editableCandidate.email
            : .constant(viewModel.candidate.email),
            isSecure: false,
            isValueVisible: .constant(false)
        )
        
        AuthTextFieldView(
            systemImage: "link",
            placeholder: "LinkedIn",
            text: viewModel.isEditing
            ? $viewModel.editableCandidate.linkedinURL
            : .constant(viewModel.candidate.linkedinURL),
            isSecure: false,
            isValueVisible: .constant(false)
        )
        
        AuthTextAreaView(
            systemImage: "text.page",
            placeholder: "",
            text: viewModel.isEditing
            ? $viewModel.editableCandidate.note
            : .constant(viewModel.candidate.note),
            maxCharacters: 300,
            isEditable: viewModel.isEditing
        )
        
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if viewModel.isEditing {
                    Button("Cancel") {
                        viewModel.cancelEditing()
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if viewModel.isEditing {
                    Button("Done") {
                        Task {
                            await viewModel.saveEditing()
                        }
                    }
                    .fontWeight(.semibold)
                } else {
                    Button("Edit") {
                        viewModel.startEditing()
                    }
                }
            }
        }
        .alert("Action non autorisée", isPresented: $showNotAuthorizedAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Seuls les administrateurs peuvent modifier le statut favori d’un candidat.")
        }
    }
}


#Preview("Favori - User Non Admin") {
    NavigationStack {
        CandidateDetailView(candidate: sampleCandidate1)
            .environmentObject({
                let session = SessionManager()
                session.startSession(
                    accessToken: "preview-token",
                    isAdmin: false
                )
                return session
            }())
    }
}

#Preview("Favori - User Admin") {
    NavigationStack {
        CandidateDetailView(candidate: sampleCandidate1)
            .environmentObject({
                let session = SessionManager()
                session.startSession(
                    accessToken: "preview-token",
                    isAdmin: true
                )
                return session
            }())
    }
}

