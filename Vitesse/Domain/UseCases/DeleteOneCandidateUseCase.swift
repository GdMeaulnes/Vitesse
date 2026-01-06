//
//  DeleteOneCandidat.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 28/12/2025.
//

// TCA - https://github.com/pointfreeco/swift-composable-architecture
// https://www.pointfree.co/collections/composable-architecture
// https://www.swiftbysundell.com/
// https://www.swiftwithvincent.com/ -> Vincent Pradeilles
// Slack : https://swift-baguette.slack.com/
// https://www.youtube.com/@Kavsoft/videos (interface)
// https://www.kodeco.com/ (anciennement Ray Wenderlich)
// https://selfh.st/ (application auto-hébergée / opensource) Jitsi


import Foundation

protocol DeleteOneCandidateUseCaseProtocol {
    func execute(id: String) async throws -> Bool
}

class DeleteOneCandidateUseCase {
    
    let userRepository = CandidateRepository()
    
    func execute(id: String) async throws ->  Bool {
        
        return try await userRepository.deleteOneCandidate(id: id)
    }
}

extension DeleteOneCandidateUseCase: DeleteOneCandidateUseCaseProtocol {}
