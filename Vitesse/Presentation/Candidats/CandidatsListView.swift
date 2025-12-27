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

                // Toggle favoris
                HStack {
                    Spacer()

                    Button {
                        viewModel.toggleFavorite()
                    } label: {
                        Image(systemName: viewModel.showFavoritesOnly ? "star.fill" : "star")
                            .foregroundColor(viewModel.showFavoritesOnly ? .yellow : .gray)
                            .font(.system(size: 20))
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.secondarySystemBackground))
                            )
                    }
                }
                .padding(.horizontal)

                // Liste de cellules individuelles
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(viewModel.candidats) { candidate in
                            CandidateRowView(candidate: candidate)
                        }
                    }
                    .padding(.horizontal)
                }
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    // À implémenter
                }
            }
        }
        .task {
            await viewModel.fetchCandidats()
        }
    }
}

extension CandidatsViewModel {
    static var preview: CandidatsViewModel {
        let vm = CandidatsViewModel()
        vm.candidats = [
            sampleCandidate1,
            sampleCandidate2
        ]
        return vm
    }
}

#Preview("Liste complète") {
    NavigationStack {
        CandidateListView()
    }
}



