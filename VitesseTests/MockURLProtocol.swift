//
//  MockURLProtocol.swift
//  VitesseTests
//
//  Created by Richard DOUXAMI on 04/01/2026.
//

import Foundation

final class MockURLProtocol: URLProtocol {

    // On va intercepter URLSession.shared et renvoyer des réponses simulées. Cela permettra de
    // tester les erreur le codage/décodage JSON
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
        // Intercepte TOUTES les requêtes
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("MockURLProtocol.requestHandler non défini")
        }

        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self,
                                didReceive: response,
                                cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {}
}
