//
//  UpdateOneCandidateUseCase.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 02/01/2026.
//

import Foundation

class ToggleFavoriteStatusUseCase {
    
    let userRepository = CandidateRepository()
    
    func execute(id: String) async throws ->  Bool {
        
        return try await userRepository.toggleFavoriteCandidateStatus(id: id)
    }
}
