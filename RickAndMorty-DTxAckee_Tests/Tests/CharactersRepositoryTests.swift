//
//  CharactersRepository_Tests.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Třešňák on 30.09.2023.
//

import XCTest
import Resolver
@testable import RickAndMorty_DTxAckee

final class CharactersRepositoryTests: XCTestCase {
    // MARK: - Properties
    @LazyInjected var dataController: MockDataController
    @LazyInjected var networkManager: MockCharacterNetworkManager
    @LazyInjected var localManager: MockCharacterLocalManager
    var sut: CharactersRepository?
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        Resolver.registerMockServices()
        sut = CharactersRepository()
    }
    override func tearDown() {
        sut = nil
        Resolver.root = .main
        super.tearDown()
    }
    // MARK: - Unit Tests
    func test_CharactersRepository_fetchAllCharactersLocal_ShouldPopulateCharacters() {
        // Given
        guard let sut = sut else { fatalError() }
        let amountOfTestSubjects = Int.random(in: 1...20)
        let testCharacters = mockArrayCharactersLocal(amountOfTestSubjects)
        localManager.result = .success(testCharacters)
        // When
        sut.fetchAllCharactersLocal()
        // Then
        XCTAssertEqual(amountOfTestSubjects, sut.characters.count)
    }
    func test_CharactersRepository_updateAllCharactersNetworkToLocal_ShouldPopulateCharacters() async {
        // Given
        guard let sut = sut else { fatalError() }
        let amountOfTestSubjects = 20
        let charactersPage = mockCharacterPage(charactersOnPage: amountOfTestSubjects)
        networkManager.result = .success(charactersPage)
        localManager.result = .success(mockArrayCharactersLocal(amountOfTestSubjects))
        // When
        await sut.updateAllCharactersNetworkToLocal()
        // Then
        XCTAssertEqual(sut.characters.count, amountOfTestSubjects)
    }
}

// MARK: - Helper Private Methods
extension CharactersRepositoryTests {
    private func mockCharacterPage(charactersOnPage: Int) -> CharacterFetchModel {
        CharacterFetchModel(info: Info(count: 800, pages: 1),
                            results: mockCharactersNetworkArray(amount: charactersOnPage))
    }
    private func mockCharactersNetworkArray(amount: Int) -> [CharacterNetwork] {
        var arrayToReturn: [CharacterNetwork] = []
        for _ in 1...amount {
            arrayToReturn.append(contentsOf:
                                    [CharacterNetwork(
                                        id: Int16.random(in: 1...9999),
                                        name: "", status: "",
                                        species: "", type: "",
                                        gender: "",
                                        origin: OriginOrLocation(name: "", url: ""),
                                        location: OriginOrLocation(name: "", url: ""),
                                        image: "",
                                        url: "",
                                        created: "")])
        }
        return arrayToReturn
    }
    private func mockCharacterLocal() -> CharacterLocal {
        let character =  CharacterLocal(context: dataController.moc)
        character.id = Int16.random(in: 1...9999)
        return character
    }
    private func mockArrayCharactersLocal(_ amount: Int) -> [CharacterLocal] {
        var array: [CharacterLocal] = []
        for _ in 1...amount {
            array.append(mockCharacterLocal())
        }
        return array
    }
}
