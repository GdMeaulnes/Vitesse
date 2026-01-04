//
//  UserAPIDataSource.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 17/12/2025.
//

import Foundation


// Classe gérant les appels API concernant les User. N'utilise que les DTO
class UserAPIDataSource {
    
    // Description: Permet de créer un compte utilisateur dans l'API
    func postNewUser(newUser: UserDTO) async throws -> Bool {
        
        var request = URLRequest(url: URL(string: (Secrets.apiProtocol + "://" + Secrets.apiHost + ":" + Secrets.apiPort + "/user/register"))!)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(newUser)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            throw UserAPIDataSourceError.invalidResponse
        }
        return true
    }
    
    
    // Description: Permet de s'authentifier dans l'API et de générer un token pour utliser l'API
    func login(client: IdDTO) async throws -> TokenDTO {
        
        var request = URLRequest(url: URL(string: (Secrets.apiProtocol + "://" + Secrets.apiHost + ":" + Secrets.apiPort + "/user/auth"))!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try JSONEncoder().encode(client)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw UserAPIDataSourceError.invalidResponse
        }
        
        do {
            let token: TokenDTO = try JSONDecoder().decode(TokenDTO.self, from: data)
            return token
        } catch {
            throw UserAPIDataSourceError.decodingError
        }
    }
}
