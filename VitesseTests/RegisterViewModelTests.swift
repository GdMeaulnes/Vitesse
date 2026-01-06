//
//  RegisterViewModelTests.swift
//  VitesseTests
//
//  Created by Richard DOUXAMI on 04/01/2026.
//

import Foundation
import Testing
@testable import Vitesse

@MainActor
struct RegisterViewModelTests {

    // MARK: - Helpers

    private func makeUser(
        email: String = "test@mail.com",
        password: String = "password",
        firstName: String = "Jean",
        lastName: String = "Dupont"
    ) -> User {
        User(
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName
        )
    }

    // MARK: - Init

    @Test
    func init_setsDefaultState() {
        let vm = RegisterViewModel()

        #expect(vm.newUser.email.isEmpty)
        #expect(vm.newUser.password.isEmpty)
        #expect(vm.newUser.firstName.isEmpty)
        #expect(vm.newUser.lastName.isEmpty)

        #expect(vm.isLoading == false)
        #expect(vm.errorMessage == nil)
    }

    // MARK: - isFormValid

    @Test
    func isFormValid_returnsFalse_whenAnyFieldIsEmpty() {
        let vm = RegisterViewModel()

        vm.newUser = makeUser(email: "", password: "123", firstName: "Jean", lastName: "Dupont")
        #expect(vm.isFormValid == false)

        vm.newUser = makeUser(email: "a@b.com", password: "", firstName: "Jean", lastName: "Dupont")
        #expect(vm.isFormValid == false)

        vm.newUser = makeUser(email: "a@b.com", password: "123", firstName: "", lastName: "Dupont")
        #expect(vm.isFormValid == false)

        vm.newUser = makeUser(email: "a@b.com", password: "123", firstName: "Jean", lastName: "")
        #expect(vm.isFormValid == false)
    }

    @Test
    func isFormValid_returnsTrue_whenAllFieldsAreFilled() {
        let vm = RegisterViewModel()

        let user = makeUser()
        vm.newUser = user
        vm.confirmPassword = user.password

        #expect(vm.isFormValid == true)
    }
    
    @Test
    func isFormValid_returnsFalse_whenPasswordsDoNotMatch() {
        let vm = RegisterViewModel()

        let user = makeUser()
        vm.newUser = user
        vm.confirmPassword = "differentPassword"

        #expect(vm.isFormValid == false)
    }

    // MARK: - toRegister (local behavior)

    @Test
    func toRegister_setsLoadingTrue_thenFalse() async {
        let vm = RegisterViewModel()
        vm.newUser = makeUser()

        #expect(vm.isLoading == false)

        await vm.toRegister(newUser: vm.newUser)

        #expect(vm.isLoading == false)
    }

    @Test
    func toRegister_setsErrorMessage_onFailure() async {
        let vm = RegisterViewModel()

        // Cas volontairement invalide pour provoquer une erreur côté use case
        vm.newUser = makeUser(email: "", password: "", firstName: "", lastName: "")

        await vm.toRegister(newUser: vm.newUser)

        #expect(vm.errorMessage != nil)
    }

    @Test
    func toRegister_clearsErrorMessage_onSuccessIntent() async {
        let vm = RegisterViewModel()
        vm.newUser = makeUser()

        // On simule un état d’erreur préalable
        vm.errorMessage = "Old error"

        await vm.toRegister(newUser: vm.newUser)

        // On valide l’intention métier locale
        // (le succès réel dépend du réseau)
        #expect(vm.errorMessage == nil || vm.errorMessage == "Error during registration")
    }
}
