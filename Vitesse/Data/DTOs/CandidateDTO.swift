//
//  CandidateDTO.swift
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

// Structure coorespondant à la table 'canditate' de la base db.sqlite
struct CandidateDataBaseDTO: Decodable {

    let id: String
    let isFavorite: Bool
    let candidate: CandidateDTO

    init(id: String, isFavorite: Bool, candidate: CandidateDTO) {
        self.id = id
        self.isFavorite = isFavorite
        self.candidate = candidate
    }

    enum CodingKeys: String, CodingKey {
        case id, isFavorite
        case firstName, lastName, email, phone, linkedinURL, note
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        isFavorite = try container.decode(Bool.self, forKey: .isFavorite)

        candidate = CandidateDTO(
            firstName: try container.decode(String.self, forKey: .firstName),
            lastName: try container.decode(String.self, forKey: .lastName),
            email: try container.decode(String.self, forKey: .email),
            phone: try container.decode(String.self, forKey: .phone),
            linkedinURL: try container.decode(String.self, forKey: .linkedinURL),
            note: try container.decode(String.self, forKey: .note)
        )
    }
}

//struct CandidateDataBaseDTO: Decodable {
//    let id: String
//    let isFavorite: Bool
//    let candidate: CandidateDTO
//
//    enum CodingKeys: String, CodingKey {
//        case id, isFavorite
//        case firstName, lastName, email, phone, linkedinURL, note
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        id = try container.decode(String.self, forKey: .id)
//        isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
//
//        candidate = CandidateDTO(
//            firstName: try container.decode(String.self, forKey: .firstName),
//            lastName: try container.decode(String.self, forKey: .lastName),
//            email: try container.decode(String.self, forKey: .email),
//            phone: try container.decode(String.self, forKey: .phone),
//            linkedinURL: try container.decode(String.self, forKey: .linkedinURL),
//            note: try container.decode(String.self, forKey: .note)
//        )
//    }
//}

// Structure inteface avec la base db.sqlite pour POST (Insert) et PUT (Update)
struct CandidateDTO: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let linkedinURL: String
    let note: String
}

