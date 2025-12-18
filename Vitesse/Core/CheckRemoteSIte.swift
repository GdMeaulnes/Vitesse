//
//  CheckRemoteSIte.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 17/12/2025.
//

import Foundation

class CheckRemoteSIte {
    
    // Description: Il s'agit d'une route pour vérifier si l'API est lancée. Doit retourner "It works" si le serveur est correctement lancé.
    func checkRemoteSite() async throws -> Bool {

        var request = URLRequest(url: URL(string: (vaporServerAdresse + "/"))!)
        request.httpMethod = "GET"
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return false
        }
        return true
    }
    
}
