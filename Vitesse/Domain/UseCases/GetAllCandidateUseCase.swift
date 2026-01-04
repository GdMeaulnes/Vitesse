//
//  GetAllCandidatUseCase.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 21/12/2025.
//

import Foundation


protocol GetAllCandidateUseCaseProtocol {
    func execute() async throws -> [Candidate]
}

class GetAllCandidateUseCase {
    
    let candidateRepository = CandidateRepository()
    
    func execute() async throws-> [Candidate] {
        
        return try await candidateRepository.getAllCandidates()
    }

}

extension GetAllCandidateUseCase: GetAllCandidateUseCaseProtocol {}
