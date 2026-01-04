//
//  CandidateAPIDataSourceTests.swift
//  VitesseTests
//
//  Created by Richard DOUXAMI on 04/01/2026.
//

import XCTest
@testable import Vitesse

@MainActor
final class CandidateAPIDataSourceTests: XCTestCase {
    
    private var session: URLSession!
    private var api: CandidateAPIDataSource!

    override func setUp() {
        super.setUp()

        // Intercepte URLSession.shared
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]

        session = URLSession(configuration: config)
        api = CandidateAPIDataSource(session: session)
    }

    override func tearDown() {
        MockURLProtocol.requestHandler = nil
        session = nil
        api = nil
        super.tearDown()
    }

    // MARK: - GET all candidats (succès)

    func test_getAllCandidats_decodesValidJSON() async throws {

        let json = """
        [
            {
                "id": "1",
                "isFavorite": true,
                "firstName": "Jean",
                "lastName": "Dupont",
                "email": "jean@dupont.com",
                "phone": "0600000000",
                "linkedinURL": "",
                "note": "Test"
            }
        ]
        """.data(using: .utf8)!

        MockURLProtocol.requestHandler = { request in
            print("MOCK UTILISÉ")
            XCTAssertEqual(request.httpMethod, "GET")
            XCTAssertTrue(request.url!.absoluteString.contains("/candidate"))

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, json)
        }

        let result = try await api.getAllCandidats()

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.candidate.firstName, "Jean")
        XCTAssertTrue(result.first?.isFavorite ?? false)
    }

    // MARK: - GET all candidats (HTTP error)

    func test_getAllCandidats_throwsError_onHTTP500() async {

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 500,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }

        do {
            _ = try await api.getAllCandidats()
            XCTFail("Une erreur était attendue")
        } catch {
            XCTAssertTrue(true)
        }
    }

    // MARK: - GET candidat by id

    func test_getCandidatById_decodesCandidate() async throws {

        let json = """
        {
            "id": "42",
            "isFavorite": false,
            "firstName": "Marie",
            "lastName": "Durand",
            "email": "marie@durand.com",
            "phone": "0611111111",
            "linkedinURL": "",
            "note": "Profil test"
        }
        """.data(using: .utf8)!

        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.httpMethod, "GET")
            XCTAssertTrue(request.url!.absoluteString.contains("/candidate/42"))

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, json)
        }

        let candidate = try await api.getCandidatById(id: "42")

        XCTAssertEqual(candidate.id, "42")
        XCTAssertEqual(candidate.candidate.lastName, "Durand")
    }
    
    func test_postNewCandidate_returnsTrue_onHTTP200() async throws {

        let dto = CandidateDTO(
            firstName: "Test",
            lastName: "Create",
            email: "test.create@mail.com",
            phone: "0600000000",
            linkedinURL: "",
            note: "Test POST"
        )

        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertTrue(request.url!.absoluteString.contains("/candidate"))
            XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
            XCTAssertTrue(request.httpBody != nil || request.httpBodyStream != nil, "Le body de la requête devrait exister (httpBody ou httpBodyStream)")

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }

        let result = try await api.postNewCandidate(candidate: dto)

        XCTAssertTrue(result)
    }
    
    func test_updateOneCandidate_returnsTrue_onHTTP200() async throws {

        let dto = CandidateDTO(
            firstName: "Updated",
            lastName: "User",
            email: "updated@mail.com",
            phone: "0611111111",
            linkedinURL: "",
            note: "Updated"
        )

        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.httpMethod, "PUT")
            XCTAssertTrue(request.url!.absoluteString.contains("/candidate/123"))
            XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
            XCTAssertTrue(request.httpBody != nil || request.httpBodyStream != nil, "Le body de la requête devrait exister (httpBody ou httpBodyStream)")

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }

        let result = try await api.updateOneCandidateById(id: "123", candidate: dto)

        XCTAssertTrue(result)
    }
    
    func test_deleteCandidate_returnsTrue_onHTTP200() async throws {

        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.httpMethod, "DELETE")
            XCTAssertTrue(request.url!.absoluteString.contains("/candidate/123"))

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }

        let result = try await api.deleteCandidatById(id: "123")

        XCTAssertTrue(result)
    }
    
    func test_toggleFavorite_returnsTrue_onHTTP200() async throws {

        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertTrue(request.url!.absoluteString.contains("/candidate/123/favorite"))

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }

        let result = try await api.toggleFavoriteCandidatById(id: "123")

        XCTAssertTrue(result)
    }
    
    func test_postNewCandidate_throwsError_onHTTP500() async {

        let dto = CandidateDTO(
            firstName: "Fail",
            lastName: "Case",
            email: "fail@mail.com",
            phone: "000",
            linkedinURL: "",
            note: ""
        )

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 500,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }

        do {
            _ = try await api.postNewCandidate(candidate: dto)
            XCTFail("Une erreur était attendue")
        } catch {
            XCTAssertTrue(true)
        }
    }
}
