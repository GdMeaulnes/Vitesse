//
//  CandidateRepository.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 20/12/2025.
//

import Foundation

class CandidateRepository {
    
    let candidateDataBaseDTO = CandidateAPIDataSource()
    
    func getAllCandidates() async throws -> [Candidate] {
        
        do {
            let candidatListDTO = try await candidateDataBaseDTO.getAllCandidats()
            
            var allCandidats : [Candidate] = []
            
            for candidatDTO in candidatListDTO {
                let newCandidat = CandidateMapper.map(candidateDataBaseDTO: candidatDTO)
                allCandidats.append(newCandidat)
            }
            return allCandidats
        }
            catch {
                throw error
            }
        }
}
