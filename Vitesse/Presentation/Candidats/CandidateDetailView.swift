//
//  CandidateDetailView.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 28/12/2025.
//

import SwiftUI

struct CandidateDetailView: View {
    
    @StateObject private var viewModel: CandidateDetailViewModel
    
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
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(viewModel.candidate.firstName) \(viewModel.candidate.lastName)")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                // Favori toujours visible
                Image(systemName: viewModel.candidate.isFavorite ? "star.fill" : "star")
                    .foregroundColor(viewModel.candidate.isFavorite ? .yellow : .gray)
                    .font(.system(size: 18))
                
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
                maxCharacters: 500,
                isEditable: viewModel.isEditing
            )
        }
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
                        viewModel.saveEditing()
                    }
                    .fontWeight(.semibold)
                } else {
                    Button("Edit") {
                        viewModel.startEditing()
                    }
                }
            }
        }
    }
}

#Preview ("Favori") {
    NavigationStack {
        CandidateDetailView(candidate: sampleCandidate1)
    }
}

#Preview("Non favori") {
    NavigationStack {
        CandidateDetailView(candidate: sampleCandidate2)
    }
}
