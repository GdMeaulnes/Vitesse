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
                    let list = try await vm.getCandidatById(id: "E96F7E52-23E1-4797-8D64-EA4A0D6DA71A")
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
                    let newCandidat : CandidateDTO = .init( firstName:  "candidat5Nom",
                                                                        lastName:  "candidat5Prenom",
                                                                        email :"candidat5@firm.com",
                                                                        phone:  "+33123456789",
                                                                        linkedinURL: "https://lienLinkedId.com",
                                                                        note :"Ceci est une note candidat")
                        
                    
                    let verdict = try await vm.postNewCandidate(candidate: newCandidat)
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
                    let candidateForUpdate = try await vm.getCandidatById(id: "E96F7E52-23E1-4797-8D64-EA4A0D6DA71A")
                    let updatedCandidat : CandidateDTO = .init( firstName:  candidateForUpdate.candidate.firstName,
                                                                lastName:  candidateForUpdate.candidate.lastName,
                                                                email :candidateForUpdate.candidate.email,
                                                                phone:  candidateForUpdate.candidate.phone,
                                                                linkedinURL: candidateForUpdate.candidate.linkedinURL,
                                                                note :"note")
                    
                    let verdict = try await vm.updateCandidateById(id: "E96F7E52-23E1-4797-8D64-EA4A0D6DA71A", candidate: updatedCandidat)
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
