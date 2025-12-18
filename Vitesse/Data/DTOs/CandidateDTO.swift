//
//  CandidateDTO.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 16/12/2025.
//

import Foundation

struct CandidateDTO: Codable {
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var linkedinURL: String
    var note: String
    var isFavorite: Bool
}

struct NewOrUpdatedCandidateDTO: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var linkedinURL: String
    var note: String
}


let sampleCandidate: CandidateDTO = .init(
    id: "E96F7E52-23E1-4797-8D64-EA4A0D6DA71A",
    firstName: "candidat1Nom",
    lastName: "candidat1Prenom",
    email: "candidat1@firm.com",
    phone: "+33987654321",
    linkedinURL: "https://lienLinkedId.com",
    note: "Ceci est une note candidat",
    isFavorite: false
)
