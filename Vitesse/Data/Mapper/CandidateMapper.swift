//
//  CandidateMapper.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 20/12/2025.
//

import Foundation

class CandidateMapper {
    
    static func map2Candidate(candidateDataBaseDTO : CandidateDataBaseDTO) -> Candidate {
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
}
