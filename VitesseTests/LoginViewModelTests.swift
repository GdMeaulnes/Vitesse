//
//  LoginViewModelTests.swift
//  VitesseTests
//
//  Created by Richard DOUXAMI on 04/01/2026.
//

import Foundation
import Testing

@testable import Vitesse

@MainActor
struct LoginViewModelTests {

    // MARK: - Mocks

    final class MockLogUserUseCase: LogUserUseCaseProtocol {
        var result: Result<LoggedInUser, Error>?

        func execute(credentials: Credentials) async throws -> LoggedInUser {
            guard let result else {
                throw NSError(domain: "MockLogUserUseCase", code: 0)
            }
            switch result {
            case .success(let user):
                return user
            case .failure(let error):
                throw error
            }
        }
    }

    final class MockSessionManager: SessionManager {
        private(set) var didStartSession = false
        private(set) var receivedToken: String?
        private(set) var receivedIsAdmin: Bool?

        override func startSession(accessToken: String, isAdmin: Bool) {
            didStartSession = true
            receivedToken = accessToken
            receivedIsAdmin = isAdmin
            super.startSession(accessToken: accessToken, isAdmin: isAdmin)
        }
    }

    // MARK: - Tests isFormValid

    @Test
    func isFormValid_isFalse_whenEmailOrPasswordEmpty() {
        let (vm, _, _) = makeSUT()

        vm.credential = Credentials(email: "", password: "")
        #expect(vm.isFormValid == false)

        vm.credential = Credentials(email: "a@b.com", password: "")
        #expect(vm.isFormValid == false)

        vm.credential = Credentials(email: "", password: "123")
        #expect(vm.isFormValid == false)
    }

    @Test
    func isFormValid_isTrue_whenEmailAndPasswordNotEmpty() {
        let (vm, _, _) = makeSUT()

        vm.credential = Credentials(email: "a@b.com", password: "123")
        #expect(vm.isFormValid == true)
    }

    // MARK: - Tests signIn success

    @Test
    func signIn_success_updatesUser_clearsError_startsSession_returnsTrue() async {
        let (vm, mockUseCase, mockSession) = makeSUT()

        vm.credential = Credentials(email: "a@b.com", password: "123")

        let expected = LoggedInUser(accessToken: "token123", isAdmin: true)
        mockUseCase.result = .success(expected)

        #expect(vm.isLoading == false)

        let success = await vm.signIn()

        #expect(success == true)
        #expect(vm.isLoading == false)
        #expect(vm.currentUser.accessToken == "token123")
        #expect(vm.currentUser.isAdmin == true)
        #expect(vm.errorMessage == nil)

        #expect(mockSession.didStartSession == true)
        #expect(mockSession.receivedToken == "token123")
        #expect(mockSession.receivedIsAdmin == true)
    }

    // MARK: - Tests signIn failure

    @Test
    func signIn_failure_setsErrorMessage_doesNotStartSession_returnsFalse() async {
        let (vm, mockUseCase, mockSession) = makeSUT()

        mockUseCase.result = .failure(NSError(domain: "Login", code: -1))

        let success = await vm.signIn()

        #expect(success == false)
        #expect(vm.isLoading == false)
        #expect(vm.errorMessage == "Logging Error")
        #expect(mockSession.didStartSession == false)
    }

    // MARK: - Helper

    private func makeSUT() -> (LoginViewModel, MockLogUserUseCase, MockSessionManager) {
        let mockSession = MockSessionManager()
        let mockUseCase = MockLogUserUseCase()

        let vm = LoginViewModel(
            sessionManager: mockSession,
            logUserUseCase: mockUseCase
        )

        return (vm, mockUseCase, mockSession)
    }
}
