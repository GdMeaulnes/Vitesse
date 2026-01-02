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
                let newCandidat = CandidateMapper.map2Candidate(candidateDataBaseDTO: candidatDTO)
                allCandidats.append(newCandidat)
            }
            return allCandidats
        }
            catch {
                throw error
            }
        }
    
    func deleteOneCandidate(id:String) async throws -> Bool {
        
        do {
            let result = try await candidateDataBaseDTO.deleteCandidatById(id: id)
            return result
        }
        catch {
            throw error
        }
    }
    
    func toggleFavoriteCandidateStatus(id:String) async throws -> Bool {
        
        do {
            let result = try await candidateDataBaseDTO.toggleFavoriteCandidatById(id: id)
            return result
        }
        catch {
            throw error
        }
    }
}
