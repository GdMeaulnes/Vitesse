//
//  Candidate.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 20/12/2025.
//

import Foundation

struct Candidate :Identifiable {
    let id: String
    let isFavorite: Bool
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let linkedinURL: String
    let note: String
}

let sampleCandidate1: Candidate = .init(
    id: "1",
    isFavorite: true,
    firstName: "Richard",
    lastName: "DOUXAMI",
    email: "richard.douxami@example.com",
    phone: "+33 612-345-678",
    linkedinURL: "https://linkedin.com/in/richard-douxami",
    note: "Top programmeur")

let sampleCandidate2: Candidate = .init(
    id: "2",
    isFavorite: false,
    firstName: "Jean-Pierre",
    lastName: "P.",
    email: "nobody@nowhere",
    phone: "+33 612-345-678",
    linkedinURL: "https://linkedin.com/in/nobody",
    note: "Bof, bof, bof")

let sampleCandidates: [Candidate] = [sampleCandidate1, sampleCandidate2]
