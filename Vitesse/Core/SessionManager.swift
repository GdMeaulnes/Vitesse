//
//  CheckRemoteSIte.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 17/12/2025.
//

import Foundation
import Combine

enum RemoteSiteError: Error {
    case siteUnavailable
}

import Foundation

// Instruments : https://developer.apple.com/tutorials/instruments
@MainActor
final class SessionManager: ObservableObject {

    // MARK: - Données de session

    @Published private(set) var accessToken: String?
    @Published private(set) var isAdmin: Bool = false

    // MARK: - État dérivé

    var isLoggedIn: Bool {
        accessToken != nil
    }

    // MARK: - API publique

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
