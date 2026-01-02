//
//  RootView.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 26/12/2025.
//

import SwiftUI

struct RootView: View {

    @EnvironmentObject private var sessionManager: SessionManager

    var body: some View {
        NavigationStack {
            if sessionManager.isLoggedIn {
                CandidateListView()
            } else {
                LoginView(sessionManager: sessionManager)
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(SessionManager())
}
