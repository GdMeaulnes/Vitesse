//
//  CandidateAPIDataSource.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 16/12/2025.
//

import Foundation



class CandidateAPIDataSource {
    
    // Description: Permet de récuperer la liste des candidats
    func getAllCandidats() async throws -> [CandidateDataBaseDTO] {
        var request = URLRequest(url: URL(string: (Secrets.apiProtocol + "://" + Secrets.apiHost + ":" + Secrets.apiPort + "/candidate"))!)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = header

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print(HTTPURLResponse.localizedString(forStatusCode: (response as? HTTPURLResponse)?.statusCode ?? 0))
            throw CandidateAPIDataSourceError.invalidResponse
        }

        do {
            let candidateDataBase: [CandidateDataBaseDTO] = try JSONDecoder().decode([CandidateDataBaseDTO].self, from: data)
            return candidateDataBase
        } catch {
            throw CandidateAPIDataSourceError.decodingError
        }
    }
    
    // Description: Permet de récuperer le détail d'un candidat via son ID (``:candidateId`)
    func getCandidatById(id: String) async throws -> CandidateDataBaseDTO {
        var request = URLRequest(url: URL(string: (Secrets.apiProtocol + "://" + Secrets.apiHost + ":" + Secrets.apiPort + "/candidate/\(id)"))!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = header
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print(HTTPURLResponse.localizedString(forStatusCode: (response as? HTTPURLResponse)?.statusCode ?? 0))
            throw CandidateAPIDataSourceError.invalidResponse
        }
        
        do {
            let candidateDataBase: CandidateDataBaseDTO = try JSONDecoder().decode(CandidateDataBaseDTO.self, from: data)
            return candidateDataBase
        } catch {
            throw CandidateAPIDataSourceError.decodingError
        }
    }
    
    // Description: Permet de créer un candidat
    func postNewCandidate(candidate: CandidateDTO) async throws -> Bool {
        var request = URLRequest(url: URL(string: (Secrets.apiProtocol + "://" + Secrets.apiHost + ":" + Secrets.apiPort + "/candidate"))!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = header
        request.httpBody = try? JSONEncoder().encode(candidate)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print(HTTPURLResponse.localizedString(forStatusCode: (response as? HTTPURLResponse)?.statusCode ?? 0))
            throw CandidateAPIDataSourceError.invalidResponse
        }
        return true
    }
    
    //Description: Permet de mettre à jour un candidat via son identifiant fourni dans l'URL (candidateId)
    // L'API oblige à donner une structure CandidateDTO complète et pas seulement le ou les champs modifiés
    // Pas d'update du champs isFavorite
    func updateCandidateById(id: String, candidate: CandidateDTO) async throws -> Bool {
        
        var request = URLRequest(url: URL(string: (Secrets.apiProtocol + "://" + Secrets.apiHost + ":" + Secrets.apiPort + "/candidate/\(id)"))!)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = header
        request.httpBody = try JSONEncoder().encode(candidate)
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
        var request = URLRequest(url: URL(string: (Secrets.apiProtocol + "://" + Secrets.apiHost + ":" + Secrets.apiPort + "/candidate/\(id)"))!)
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
        var request = URLRequest(url: URL(string: (Secrets.apiProtocol + "://" + Secrets.apiHost + ":" + Secrets.apiPort + "/candidate/\(id)/favorite"))!)
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

