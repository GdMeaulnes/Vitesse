//
//  CandidateDetailViewModel.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 28/12/2025.
//

import Foundation
import Combine
import SwiftUI

final class CandidateDetailViewModel: ObservableObject {
    
    @Published var candidate: Candidate
    @Published var editableCandidate: Candidate
    
    @Published var isEditing: Bool = false
    
    init(candidate: Candidate) {
        self.candidate = candidate
        self.editableCandidate = candidate
    }
    
    func startEditing() {
        editableCandidate = candidate
        isEditing = true
    }
    
    func cancelEditing() {
        editableCandidate = candidate
        isEditing = false
    }
    
    func saveEditing() {
        candidate = editableCandidate
        isEditing = false
        // 👉 ici plus tard : sauvegarde DB / API
    }
}

