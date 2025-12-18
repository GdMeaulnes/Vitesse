//
//  CandidateAPIDataSource.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 16/12/2025.
//

import Foundation

enum CandidateAPIDataSourceError: Error {
    case invalidResponse
    case noDataReturned
    case decodingError
}

class CandidateAPIDataSource {
    
    // Description: Permet de récuperer la liste des candidats
    func getAllCandidats() async throws -> [CandidateDTO] {
        var request = URLRequest(url: URL(string: (vaporServerAdresse + "/candidate"))!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = header

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print(HTTPURLResponse.localizedString(forStatusCode: (response as? HTTPURLResponse)?.statusCode ?? 0))
            throw CandidateAPIDataSourceError.invalidResponse
        }

        do {
            let candidats: [CandidateDTO] = try JSONDecoder().decode([CandidateDTO].self, from: data)
            return candidats
        } catch {
            throw CandidateAPIDataSourceError.decodingError
        }
    }
    
    // Description: Permet de récuperer le détail d'un candidat via son ID (``:candidateId`)
    func getCandidatById(id: String) async throws -> CandidateDTO {
        var request = URLRequest(url: URL(string: (vaporServerAdresse + "/candidate/\(id)"))!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = header
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print(HTTPURLResponse.localizedString(forStatusCode: (response as? HTTPURLResponse)?.statusCode ?? 0))
            throw CandidateAPIDataSourceError.invalidResponse
        }
        
        do {
            let candidat: CandidateDTO = try JSONDecoder().decode(CandidateDTO.self, from: data)
            return candidat
        } catch {
            throw CandidateAPIDataSourceError.decodingError
        }
    }
    
    // Description: Permet de créer un candidat
    func postNewCandidate(candidat: NewOrUpdatedCandidateDTO) async throws -> Bool {
        var request = URLRequest(url: URL(string: (vaporServerAdresse + "/candidate"))!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = header
        request.httpBody = try? JSONEncoder().encode(candidat)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print(HTTPURLResponse.localizedString(forStatusCode: (response as? HTTPURLResponse)?.statusCode ?? 0))
            throw CandidateAPIDataSourceError.invalidResponse
        }
        return true
    }
    
    //Description: Permet de mettre à jour un candidat via son identifiant fourni dans l'URL (candidateId)
    // Pas d'update du champs isFavorite
    func updateCandidateById(candidat: CandidateDTO) async throws -> Bool {
        let id = candidat.id
        let updatedCandidate : NewOrUpdatedCandidateDTO = .init(firstName : candidat.firstName,
                                                                lastName : candidat.lastName,
                                                                email : candidat.email,
                                                                phone: candidat.phone,
                                                                linkedinURL : candidat.linkedinURL,
                                                                note : candidat.note)
        
        var request = URLRequest(url: URL(string: (vaporServerAdresse + "/candidate/\(id)"))!)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = header
        request.httpBody = try JSONEncoder().encode(updatedCandidate)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print(HTTPURLResponse.localizedString(forStatusCode: (response as? HTTPURLResponse)?.statusCode ?? 0))
            throw CandidateAPIDataSourceError.invalidResponse
        }
        
        return true
    }
    
    
    // Description: Permet de supprimer un candidat
    func deleteCandidatById(id: String) async throws -> Bool {
        var request = URLRequest(url: URL(string: (vaporServerAdresse + "/candidate/\(id)"))!)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = header
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print(HTTPURLResponse.localizedString(forStatusCode: (response as? HTTPURLResponse)?.statusCode ?? 0))
            throw CandidateAPIDataSourceError.invalidResponse
        }
        
        return true
    }
    
    // Description: Permet de changer le status de favoris du candidat (admin uniquement)
    func toggleFavoriteCandidatById(id: String) async throws -> Bool {
        var request = URLRequest(url: URL(string: (vaporServerAdresse + "/candidate/\(id)/favorite"))!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = header
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print(HTTPURLResponse.localizedString(forStatusCode: (response as? HTTPURLResponse)?.statusCode ?? 0))
            throw CandidateAPIDataSourceError.invalidResponse
        }
        
        return true
    }
}
