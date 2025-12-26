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
    
    @Published var candidats: [Candidate] = []
    @Published var isLoading: Bool = false
    @Published var isPasswordVisible: Bool = false
    @Published var errorMessage: String?
    
    @Published var showFavoritesOnly: Bool = false
    
    private var candidatsLoaded : [Candidate] = []
    // filteredCandidates: [Candidate] = []
    // private var favoritecandidats: [Candidate] = []

    let getAllCandidateUseCase = GetAllCandidateUseCase()
    
    func fetchCandidats() async {
        do {
            isLoading = true
            candidatsLoaded = try await getAllCandidateUseCase.execute()
            errorMessage = nil
        } catch {
            errorMessage = "Une erreur s'est produite"
        }
        isLoading = false
    }
    /*
    func favoriteCandidats() {
        for candidat in candidatsLoaded {
            if candidat.isFavorite == true {
                favoritecandidats.append(candidat)
            }
        }

        candidats = candidatsLoaded.compactMap { $0.isFavorite == true }
    }
    
    func showAllCandidats() {
        candidats = candidatsLoaded
    }
    
    func showFavoriteCandidats() {
        candidats = favoritecandidats
    }
    
    private func applyFilter() {
        if showFavoritesOnly {
            showFavoriteCandidats()
        } else {
            showAllCandidats()
        }
    }*/
    
    //
    
    func toggleFavorite() {
         showFavoritesOnly.toggle()
        
        if showFavoritesOnly {
            candidats = candidatsLoaded.filter { $0.isFavorite == true }
        } else {
            candidats = candidatsLoaded
        }
    }
}
