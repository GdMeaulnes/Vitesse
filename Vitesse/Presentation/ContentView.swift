//
//  ContentView.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 16/12/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button {
            Task {
                let candidates = CandidateAPIDataSource()
                
                do {
                    let list = try await candidates.getAllCandidats()
                    print(list)
                } catch {
                    print(error)
                }
            }
        } label: {
            Text("Test de recup des candidats")
        }

    }
}

#Preview {
    ContentView()
}
