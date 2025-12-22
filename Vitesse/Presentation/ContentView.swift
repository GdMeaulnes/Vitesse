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
                let vm = LogUserUseCase()
                
                let credentials = Credentials(email: "user4@vitesse.com", password: "user4")
                
                do {
                    let result = try await vm.execute(credentials: credentials)
                    
                    print(result)
                } catch {
                    print(error)
                }
            }
        } label: {
            Text("Test de loggin")
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
    
        
    }
}

#Preview {
    ContentView()
}
