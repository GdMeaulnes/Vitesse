//
//  UpdateCandidateUseCase.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 02/01/2026.
//

import Foundation

class UpdateOneCandidateUseCase {
    
    let userRepository = CandidateRepository()
    
    func execute(canditate: Candidate) async throws ->  Bool {
        
        return try await userRepository.updateOneCandidate(candidate: canditate)
        
    }
}
