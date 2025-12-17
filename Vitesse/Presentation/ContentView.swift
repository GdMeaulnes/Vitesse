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
        Button {
            Task {
                let candidat = CandidateAPIDataSource()
                
                do {
                    let list = try await candidat.getCandidatById(id: "0EEA6692-C3D6-4D2B-A170-F88674F2F005")
                    print(list)
                } catch {
                    print(error)
                }
            }
        } label: {
            Text("Test de recup d'un candidat par son Id")
        }
        
        Button {
            Task {
                print(isSiteAlive)
                let check = CheckRemoteSIte()
                let result = try await check.checkRemoteSite()
                print(result)
                print(isSiteAlive)
            }
        } label: {
            Text("Vérification du site distant")
                .foregroundColor(isSiteAlive ? .green : .red)
        }
    }
}

#Preview {
    ContentView()
}
