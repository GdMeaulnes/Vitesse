//
//  DeleteOneCandidat.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 28/12/2025.
//

import Foundation

protocol DeleteOneCandidateUseCaseProtocol {
    func execute(id: String) async throws -> Bool
}

class DeleteOneCandidateUseCase {
    
    let userRepository = CandidateRepository()
    
    func execute(id: String) async throws ->  Bool {
        
        return try await userRepository.deleteOneCandidate(id: id)
    }
}

extension DeleteOneCandidateUseCase: DeleteOneCandidateUseCaseProtocol {}
