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
    
    // func getCandidatById
    
}
