//
//  VitesseApp.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 16/12/2025.
//

import SwiftUI

@main
struct VitesseApp: App {
    @StateObject private var sessionManager = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(sessionManager)
        }
    }
}
