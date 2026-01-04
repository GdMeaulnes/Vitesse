//
//  SessionManager.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 17/12/2025.
//
// Permet de mémoriser les données de retour du login user et de les rendre accesible dans toute l'App.
//
import Foundation
import Combine

enum RemoteSiteError: Error {
    case siteUnavailable
}

import Foundation


@MainActor
class SessionManager: ObservableObject {

    // Données mémorisées
    @Published private(set) var accessToken: String?
    @Published private(set) var isAdmin: Bool = false

    var isLoggedIn: Bool {
        accessToken != nil
    }
    
    func startSession(accessToken: String, isAdmin: Bool) {
        self.accessToken = accessToken
        self.isAdmin = isAdmin
    }

    func endSession() {
        self.accessToken = nil
        self.isAdmin = false
    }
    
    // Description: Il s'agit d'une route pour vérifier si l'API est lancée. Doit retourner "It works" si le serveur est correctement lancé.
   func checkRemoteSite() async throws -> Bool {

       var request = URLRequest(url: URL(string: (Secrets.apiProtocol + "://" + Secrets.apiHost + ":" + Secrets.apiPort + "/"))!)
       request.httpMethod = "GET"
       
       let (_, response) = try await URLSession.shared.data(for: request)
       
       guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
           throw RemoteSiteError.siteUnavailable
       }
       return true
   }
}
