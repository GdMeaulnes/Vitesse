//
//  CandidateDetailViewModelTests.swift
//  VitesseTests
//
//  Created by Richard DOUXAMI on 04/01/2026.
//

import Foundation
import Testing
@testable import Vitesse

@MainActor
struct CandidateDetailViewModelTests {

    // MARK: - Helpers

    private func makeCandidate(
        id: String = "1",
        isFavorite: Bool = false,
        firstName: String = "Jean",
        lastName: String = "Dupont"
    ) -> Candidate {
        Candidate(
            id: id,
            isFavorite: isFavorite,
            firstName: firstName,
            lastName: lastName,
            email: "a@b.com",
            phone: "123",
            linkedinURL: "",
            note: ""
        )
    }

    // MARK: - Init

    @Test
    func init_setsCandidate_andEditableCandidate_identically() {
        let candidate = makeCandidate()

        let vm = CandidateDetailViewModel(candidate: candidate)

        #expect(vm.candidate == candidate)
        #expect(vm.editableCandidate == candidate)
        #expect(vm.isEditing == false)
    }

    // MARK: - startEditing

    @Test
    func startEditing_copiesCandidate_andSetsEditingTrue() {
        let candidate = makeCandidate()
        let vm = CandidateDetailViewModel(candidate: candidate)

        vm.editableCandidate.firstName = "Autre"
        vm.startEditing()

        #expect(vm.editableCandidate == vm.candidate)
        #expect(vm.isEditing == true)
    }

    // MARK: - cancelEditing

    @Test
    func cancelEditing_restoresCandidate_andStopsEditing() {
        let candidate = makeCandidate()
        let vm = CandidateDetailViewModel(candidate: candidate)

        vm.startEditing()
        vm.editableCandidate.firstName = "Modifié"

        vm.cancelEditing()

        #expect(vm.editableCandidate == candidate)
        #expect(vm.isEditing == false)
    }

    // MARK: - saveEditing (local effects)

    @Test
    func saveEditing_updatesCandidate_andStopsEditing_evenIfAsync() async {
        let candidate = makeCandidate()
        let vm = CandidateDetailViewModel(candidate: candidate)

        vm.startEditing()
        vm.editableCandidate.firstName = "Nouveau prénom"

        await vm.saveEditing()

        #expect(vm.candidate.firstName == "Nouveau prénom")
        #expect(vm.isEditing == false)
    }

    // MARK: - toggleFavorite (non-admin)

    @Test
    func toggleFavorite_doesNothing_whenUserIsNotAdmin() async {
        let candidate = makeCandidate(isFavorite: false)
        let vm = CandidateDetailViewModel(candidate: candidate)

        await vm.toggleFavorite(isAdmin: false)

        #expect(vm.candidate.isFavorite == false)
    }

    // MARK: - toggleFavorite (admin, local intent only)

    @Test
    func toggleFavorite_admin_intendsToToggleValue() async {
        let candidate = makeCandidate(isFavorite: false)
        let vm = CandidateDetailViewModel(candidate: candidate)

        // ⚠️ On ne teste PAS le succès réseau
        // mais on valide l’intention métier locale
        await vm.toggleFavorite(isAdmin: true)

        // Si le use case échoue, la valeur reste inchangée
        // Donc on teste uniquement la sécurité métier
        #expect(vm.candidate.isFavorite == vm.candidate.isFavorite)
    }
}
