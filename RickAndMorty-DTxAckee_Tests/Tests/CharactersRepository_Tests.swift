//
//  CharactersRepository_Tests.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Třešňák on 30.09.2023.
//

import XCTest
import Resolver
@testable import RickAndMorty_DTxAckee

final class CharactersRepository_Tests: XCTestCase {

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
        guard let sut = sut else { fatalError() }

        // Given
        let amountOfTestSubjects = 10
        let testCharacters = mockArrayCharactersLocal(amountOfTestSubjects)
        localManager.result = .success(testCharacters)

        // When
        sut.fetchAllCharactersLocal()
    
        // Then
        XCTAssertEqual(amountOfTestSubjects, sut.characters.count)
    }
    
    
    
}

// MARK: - Helper Private Methods

extension CharactersRepository_Tests {
    
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
