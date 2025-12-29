//
//  CandidatsView.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 26/12/2025.
//

import SwiftUI

struct CandidateListView: View {
    
    @StateObject private var viewModel = CandidatsViewModel()
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 12) {
                
                SearchBarView(text: $viewModel.searchText)
                
                // Liste de cellules individuelles
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(viewModel.candidats) { candidate in
                            NavigationLink {
                                CandidateDetailView(candidate: candidate)
                            } label: {
                                CandidateRowView(
                                    candidate: candidate,
                                    isEditing: viewModel.isEditing,
                                    isSelected: viewModel.selectedCandidateIDs.contains(candidate.id)
                                )
                            }
                            .disabled(viewModel.isEditing) 
                            .onTapGesture {
                                if viewModel.isEditing {
                                    viewModel.toggleSelection(for: candidate)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            // Loader superposé
            if viewModel.isLoading {
                ProgressView("Chargement des candidats…")
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
            }
        }
        .navigationTitle("Candidats")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                if viewModel.isEditing {
                    Button("Cancel") {
                        viewModel.cancelEditing()
                    }
                } else {
                    Button("Edit") {
                        viewModel.isEditing = true
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if viewModel.isEditing {
                    Button("Delete") {
                        Task {
                            await viewModel.deleteSelectedCandidats()
                        }
                    }
                    .disabled(viewModel.selectedCandidateIDs.isEmpty)
                    .foregroundColor(.red)
                } else {
                    Button {
                        viewModel.toggleFavorite()
                    } label: {
                        Image(systemName: viewModel.showFavoritesOnly ? "star.fill" : "star")
                            .foregroundColor(viewModel.showFavoritesOnly ? .yellow : .primary)
                    }
                }
            }
        }
//        .searchable(
//            text: $viewModel.searchText,
//            placement: .navigationBarDrawer(displayMode: .automatic),
//            prompt: "Search"
//        )
        .task {
            await viewModel.fetchCandidats()
        }
    }
}


#Preview("Liste complète") {
        CandidateListView()
}

