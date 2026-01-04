//
//  BackEndSmokeTests.swift
//  VitesseTests
//
//  Created by Richard DOUXAMI on 04/01/2026.
//

import XCTest
@testable import Vitesse

final class BackendSmokeTests: XCTestCase {

    func test_backend_isAlive() async {
        let sessionManager = await SessionManager()

        do {
            let isAlive = try await sessionManager.checkRemoteSite()
            XCTAssertTrue(isAlive)
        } catch {
            XCTFail("Le backend est inaccessible : \(error)")
        }
    }
}
