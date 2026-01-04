//
//  CandidateDetailViewModel.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 28/12/2025.
//

import Foundation
import Combine
import SwiftUI

final class CandidateDetailViewModel: ObservableObject {
    
    // Les Uses Cases de l'Écran de profil du candidat (Paragraphe 4 des specs)
    let toggleFavoriteStatusUseCase = ToggleFavoriteStatusUseCase()
    let updateOneCandidateUseCase = UpdateOneCandidateUseCase()
    let getAllCandidateUseCase = GetAllCandidateUseCase()
    
    @Published var candidate: Candidate
    @Published var editableCandidate: Candidate
    
    @Published var isEditing: Bool = false
    
    init(candidate: Candidate) {
        self.candidate = candidate
        self.editableCandidate = candidate
    }
    
    func startEditing() {
        editableCandidate = candidate
        isEditing = true
    }
    
    func cancelEditing() {
        editableCandidate = candidate
        isEditing = false
    }
    
    func saveEditing() async {
        candidate = editableCandidate
        isEditing = false
        
        do {
            _ = try await updateOneCandidateUseCase.execute(canditate: candidate)
            _ = try await getAllCandidateUseCase.execute()
            
        } catch {
            print("Erreur MAJ candidat :", error)
        }
    }
    
    func toggleFavorite(isAdmin: Bool) async {
        guard isAdmin else { return }

        let newValue = !candidate.isFavorite

        do {
            _ = try await toggleFavoriteStatusUseCase.execute(id: candidate.id)
                candidate.isFavorite = newValue          
        } catch {
            // Option : afficher une alerte
            print("Erreur MAJ favori :", error)
        }
    }
}

