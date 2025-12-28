//
//  CandidateRowView.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 26/12/2025.
//

import SwiftUI

struct CandidateRowView: View {

    let candidate: Candidate
    let isEditing: Bool
    let isSelected: Bool

    var body: some View {
        HStack {

            // Indicateur de sélection (édition)
            if isEditing {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSelected ? .blue : .gray)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("\(candidate.firstName) \(candidate.lastName)")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
            }

            Spacer()

            // Favori toujours visible
            Image(systemName: candidate.isFavorite ? "star.fill" : "star")
                .foregroundColor(candidate.isFavorite ? .yellow : .gray)
                .font(.system(size: 18))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected && isEditing
                      ? Color.blue.opacity(0.12)
                      : Color(.secondarySystemBackground))
        )
        .animation(.default, value: isSelected)
    }
}

#Preview {
    CandidateRowView(candidate: sampleCandidate1, isEditing: true , isSelected: true)
}

#Preview {
    CandidateRowView(candidate: sampleCandidate2, isEditing: false, isSelected: false)
}
