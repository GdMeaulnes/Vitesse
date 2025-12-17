//
//  CandidateDTO.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 16/12/2025.
//

import Foundation

struct CandidateDTO: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let linkedinURL: String
    let note: String
    let isFavorite: Bool
}

struct NewCandidateDTO: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let linkedinURL: String
    let note: String
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
