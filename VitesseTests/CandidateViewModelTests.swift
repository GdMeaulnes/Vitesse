//
//  CandidateViewModelTests.swift
//  VitesseTests
//
//  Created by Richard DOUXAMI on 04/01/2026.
//

import Foundation
import Testing
@testable import Vitesse

@MainActor
struct CandidatsViewModelTests {

    // MARK: - Mocks

    final class MockGetAllCandidateUseCase: GetAllCandidateUseCaseProtocol {
        var result: Result<[Candidate], Error>?

        func execute() async throws -> [Candidate] {
            guard let result else {
                throw MockError.notConfigured
            }
            switch result {
            case .success(let candidats):
                return candidats
            case .failure(let error):
                throw error
            }
        }
    }

    final class MockDeleteCandidateUseCase: DeleteOneCandidateUseCaseProtocol {
        var deletedIDs: [String] = []

        func execute(id: String) async throws -> Bool {
            deletedIDs.append(id)
            return true
        }
    }

    enum MockError: Error {
        case notConfigured
        case failure
    }

    // MARK: - Tests fetchCandidats

    @Test
    func fetchCandidats_success_populatesList_andClearsError() async {
        let (vm, mockGet, _) = makeSUT()

        let candidats = [
            Candidate(id: "1", isFavorite: true, firstName: "Jean", lastName: "Dupont",
                      email: "", phone: "", linkedinURL: "", note: ""),
            Candidate(id: "2", isFavorite: false, firstName: "Marie", lastName: "Durand",
                      email: "", phone: "", linkedinURL: "", note: "")
        ]

        mockGet.result = .success(candidats)

        await vm.fetchCandidats()

        #expect(vm.isLoading == false)
        #expect(vm.errorMessage == nil)
        #expect(vm.candidats.count == 2)
    }

    @Test
    func fetchCandidats_failure_setsErrorMessage() async {
        let (vm, mockGet, _) = makeSUT()

        mockGet.result = .failure(MockError.failure)

        await vm.fetchCandidats()

        #expect(vm.isLoading == false)
        #expect(vm.errorMessage != nil)
        #expect(vm.candidats.isEmpty)
    }

    // MARK: - Filtering tests

    @Test
    func candidats_filtersFavoritesOnly() async {
        let (vm, mockGet, _) = makeSUT()

        mockGet.result = .success(sampleCandidates())

        await vm.fetchCandidats()

        vm.showFavoritesOnly = true

        #expect(vm.candidats.count == 1)
        #expect(vm.candidats.first?.isFavorite == true)
    }

    @Test
    func candidats_filtersBySearchText() async {
        let (vm, mockGet, _) = makeSUT()

        mockGet.result = .success(sampleCandidates())

        await vm.fetchCandidats()

        vm.searchText = "dupont"

        #expect(vm.candidats.count == 1)
        #expect(vm.candidats.first?.lastName == "Dupont")
    }

    // MARK: - Selection

    @Test
    func toggleSelection_addsAndRemovesCandidateID() {
        let (vm, _, _) = makeSUT()

        let candidate = sampleCandidates().first!

        vm.toggleSelection(for: candidate)
        #expect(vm.selectedCandidateIDs.contains(candidate.id))

        vm.toggleSelection(for: candidate)
        #expect(vm.selectedCandidateIDs.isEmpty)
    }

    // MARK: - Delete selected

    @Test
    func deleteSelectedCandidats_deletesAll_andResetsState() async {
        let (vm, mockGet, mockDelete) = makeSUT()

        let candidats = sampleCandidates()
        mockGet.result = .success(candidats)

        await vm.fetchCandidats()

        vm.selectedCandidateIDs = ["1", "2"]
        vm.isEditing = true

        await vm.deleteSelectedCandidats()

        #expect(mockDelete.deletedIDs.count == 2)
        #expect(vm.selectedCandidateIDs.isEmpty)
        #expect(vm.isEditing == false)
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        CandidatsViewModel,
        MockGetAllCandidateUseCase,
        MockDeleteCandidateUseCase
    ) {
        let mockGet = MockGetAllCandidateUseCase()
        let mockDelete = MockDeleteCandidateUseCase()

        let vm = CandidatsViewModel(
            getAllCandidateUseCase: mockGet,
            deleteCandidateUseCase: mockDelete
        )

        return (vm, mockGet, mockDelete)
    }

    private func sampleCandidates() -> [Candidate] {
        [
            Candidate(id: "1", isFavorite: true, firstName: "Jean", lastName: "Dupont",
                      email: "", phone: "", linkedinURL: "", note: ""),
            Candidate(id: "2", isFavorite: false, firstName: "Marie", lastName: "Durand",
                      email: "", phone: "", linkedinURL: "", note: "")
        ]
    }
}
