//
//  CandidateRowView.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 26/12/2025.
//

import SwiftUI

struct CandidateRowView: View {

    let candidate: Candidate

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(candidate.firstName) \(candidate.lastName)")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
            }

            Spacer()

            Image(systemName: candidate.isFavorite ? "star.fill" : "star")
                .foregroundColor(candidate.isFavorite ? .yellow : .gray)
                .font(.system(size: 18))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    CandidateRowView(candidate: sampleCandidate1)
}

#Preview {
    CandidateRowView(candidate: sampleCandidate2)
}
