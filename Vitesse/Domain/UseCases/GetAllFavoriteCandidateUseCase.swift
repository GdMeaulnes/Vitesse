//
//  GetAllFavoriteCandidate.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 21/12/2025.
//

import Foundation

class GetAllFavoriteCandidateUseCase {
    
    let candidateRepository = CandidateRepository()
    
    func execute() async throws-> [Candidate] {
        
        var favoriteCandidate: [Candidate] = []
        
        let allCandidate = try await candidateRepository.getAllCandidates()
        
        for candidate in allCandidate {
            if candidate.isFavorite == true {
                favoriteCandidate.append(candidate)
            }
        }
        return favoriteCandidate
    }
}
