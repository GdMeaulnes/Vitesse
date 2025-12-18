//
//  ContentView.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 16/12/2025.
//

import SwiftUI

var isSiteAlive = false

struct ContentView: View {
    var body: some View {
        Button {
            Task {
                let vm = CandidateAPIDataSource()
                
                do {
                    let list = try await vm.getAllCandidats()
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
                let vm = CandidateAPIDataSource()
                
                do {
                    let list = try await vm.getCandidatById(id: "0EEA6692-C3D6-4D2B-A170-F88674F2F005")
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
                let vm = CandidateAPIDataSource()
                
                do {
                    let newCandidat : NewOrUpdatedCandidateDTO = .init( firstName:  "candidat4Nom",
                                                                        lastName:  "candidat4Prenom",
                                                                        email :"candidat4@firm.com",
                                                                        phone:  "+33123456789",
                                                                        linkedinURL: "https://lienLinkedId.com",
                                                                        note :"Ceci est une note candidat")
                        
                    
                    let verdict = try await vm.postNewCandidate(candidat: newCandidat)
                    print(verdict)
                } catch {
                    print(error)
                }
            }
        } label: {
            Text("Ajout d'un candidat")
        }
        
        Button {
            Task {
                let vm = CandidateAPIDataSource()
                
                do {
                    var candidatMaj = try await vm.getCandidatById(id: "A8C1D08B-D5E4-4331-A340-7061E45744D2")
                    candidatMaj.note = "N'importe quoi"
                    
                    let verdict = try await vm.updateCandidateById(candidat: candidatMaj)
                    print(verdict)
                } catch {
                    print(error)
                }
            }
        } label: {
            Text("Update d'un candidat")
        }
    }
}

#Preview {
    ContentView()
}
