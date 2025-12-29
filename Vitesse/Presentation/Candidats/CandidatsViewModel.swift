//
//  CandaidatsViewModel.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 26/12/2025.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class CandidatsViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var isPasswordVisible: Bool = false
    @Published var errorMessage: String?
    @Published var isEditing: Bool = false
    @Published var selectedCandidateIDs: Set<String> = []
    
    @Published var showFavoritesOnly: Bool = false
    @Published var searchText: String = ""
    
    private var candidatsLoaded : [Candidate] = []
    
    var candidats : [Candidate] {
        candidatsLoaded.filter { candidat in

                // Filtre favoris
                let matchFavorite =
                    !showFavoritesOnly || candidat.isFavorite

                // Filtre texte (prénom + nom)
                let matchSearch: Bool
                if searchText.isEmpty {
                    matchSearch = true
                } else {
                    let fullName = "\(candidat.lastName) \(candidat.firstName)"
                        .lowercased()

                    matchSearch = fullName.contains(searchText.lowercased())
                }

                return matchFavorite && matchSearch
            }
    }
    
//    let normalizedSearch = searchText
//        .lowercased()
//        .folding(options: .diacriticInsensitive, locale: .current)
//
//    let fullName = "\(candidat.prenom) \(candidat.nom)"
//        .lowercased()
//        .folding(options: .diacriticInsensitive, locale: .current)
//
//    let matchSearch = normalizedSearch.isEmpty
//        || fullName.contains(normalizedSearch)

    let getAllCandidateUseCase = GetAllCandidateUseCase()
    
    let deleteCandidateUseCase = DeleteOneCandidateUseCase()
    
    func fetchCandidats() async {
        do {
            isLoading = true
            candidatsLoaded = try await getAllCandidateUseCase.execute()
            errorMessage = nil
        } catch {
            errorMessage = "Une erreur de chargement s'est produite \(error)"
        }
        // toggleFavorite()
        isLoading = false
    }
    
    func toggleFavorite() {
        showFavoritesOnly.toggle()
        searchText = ""
    }
    
    func deleteOneCandidate(id: String) async {
        do {
            isLoading = true
            try await deleteCandidateUseCase.execute(id: id)
        } catch {
            print("Une erreur d'effacement s'est produite: \(error)")
        }
        isLoading = false
    }
    
    func deleteSelectedCandidats() async {

        guard !selectedCandidateIDs.isEmpty else { return }

        isLoading = true
        defer { isLoading = false }

        for id in selectedCandidateIDs {
            await deleteOneCandidate(id: id)
        }
        await fetchCandidats()

        // Mise à jour locale
        candidatsLoaded.removeAll { candidat in
            selectedCandidateIDs.contains(candidat.id)
        }

        selectedCandidateIDs.removeAll()
        isEditing = false
    }
    
    func toggleSelection(for candidate: Candidate) {
        let id = candidate.id

        if selectedCandidateIDs.contains(id) {
            selectedCandidateIDs.remove(id)
        } else {
            selectedCandidateIDs.insert(id)
        }
    }
    
    func cancelEditing() {
        selectedCandidateIDs.removeAll()
        isEditing = false
    }
}

