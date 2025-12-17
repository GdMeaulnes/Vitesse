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
    
    func postNewCandidate(candidat: NewCandidateDTO) async throws -> CandidateDTO {
        var request = URLRequest(url: URL(string: (vaporServerAdresse + "/candidate"))!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = header
        request.httpBody = try? JSONEncoder().encode(candidat)
        
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
