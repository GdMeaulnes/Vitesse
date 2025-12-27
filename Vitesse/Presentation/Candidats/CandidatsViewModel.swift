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
    
    @Published var showFavoritesOnly: Bool = true
    
    private var candidatsLoaded : [Candidate] = []

    let getAllCandidateUseCase = GetAllCandidateUseCase()
    
    func fetchCandidats() async {
        do {
            isLoading = true
            candidatsLoaded = try await getAllCandidateUseCase.execute()
            errorMessage = nil
        } catch {
            errorMessage = "Une erreur s'est produite"
        }
        toggleFavorite()
        isLoading = false
    }
    
    func toggleFavorite() {
         showFavoritesOnly.toggle()
        
        if showFavoritesOnly {
            candidats = candidatsLoaded.filter { $0.isFavorite == true }
        } else {
            candidats = candidatsLoaded
        }
    }
}
