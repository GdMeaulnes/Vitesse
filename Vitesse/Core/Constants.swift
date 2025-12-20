//
//  Constants.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 16/12/2025.
//

import Foundation

// Regarder comment intégrer un fichier .env
let header = ["authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImFkbWluQHZpdGVzc2UuY29tIiwiaXNBZG1pbiI6dHJ1ZX0.66y2jHqt-w3dQgc-W9sHMBhDN7BIHOq8X7IL3H--NzY"]

enum Secrets {
    static var adminName: String { Bundle.main.infoDictionary?["API_ADMIN_NAME"] as? String ?? "" }
    static var adminPassword: String { Bundle.main.infoDictionary?["API_ADMIN_PWD"] as? String ?? "" }
    static var apiProtocol: String { Bundle.main.infoDictionary?["API_PROTOCOL"] as? String ?? ""}
    static var apiHost: String { Bundle.main.infoDictionary?["API_HOST"] as? String ?? ""}
    static var apiPort: String { Bundle.main.infoDictionary?["API_PORT"] as? String ?? ""}
}
