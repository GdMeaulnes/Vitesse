//
//  CandidateMapper.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 20/12/2025.
//

import Foundation

class CandidateMapper {
    
    static func mapToCandidate(candidateDataBaseDTO : CandidateDataBaseDTO) -> Candidate {
        return Candidate(
            id: candidateDataBaseDTO.id,
            isFavorite: candidateDataBaseDTO.isFavorite,
            firstName: candidateDataBaseDTO.candidate.firstName,
            lastName: candidateDataBaseDTO.candidate.lastName,
            email: candidateDataBaseDTO.candidate.email,
            phone: candidateDataBaseDTO.candidate.phone,
            linkedinURL: candidateDataBaseDTO.candidate.linkedinURL,
            note: candidateDataBaseDTO.candidate.note)
    }
    
    static func mapToCandidateDTO(from candidate: Candidate) -> CandidateDTO {
        return CandidateDTO(
            firstName: candidate.firstName,
            lastName: candidate.lastName,
            email: candidate.email,
            phone: candidate.phone,
            linkedinURL: candidate.linkedinURL,
            note: candidate.note
        )	
    }
    
    static func mapToCandidateDatabaseDTO(from candidate: Candidate) -> CandidateDataBaseDTO {

        let candidateDTO = CandidateDTO(
            firstName: candidate.firstName,
            lastName: candidate.lastName,
            email: candidate.email,
            phone: candidate.phone,
            linkedinURL: candidate.linkedinURL,
            note: candidate.note
        )

        return CandidateDataBaseDTO(
            id: candidate.id,
            isFavorite: candidate.isFavorite,
            candidate: candidateDTO
        )
    }
    
}
