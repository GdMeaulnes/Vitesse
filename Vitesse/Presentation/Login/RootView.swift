//
//  RootView.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 26/12/2025.
//

import SwiftUI

struct RootView: View {

    @State private var isLoggedIn = false

    var body: some View {
        NavigationStack {
            if isLoggedIn {
                CandidateListView()
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}

#Preview {
    RootView()
}
