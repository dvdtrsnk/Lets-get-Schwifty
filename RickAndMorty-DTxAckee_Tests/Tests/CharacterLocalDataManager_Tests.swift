//
//  CharacterLocalDataManager_Tests.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Tresnak
//

import XCTest
import Resolver
import CoreData
@testable import RickAndMorty_DTxAckee

final class CharacterLocalDataManager_Tests: XCTestCase {
    
    @LazyInjected var dataController: MockDataController
    var sut: CharacterLocalDataManager?
    var characters: [CharacterLocal] = []
    
    // MARK: - Life Cycle
    
    override func setUp() {
        super.setUp()
        Resolver.registerMockServices()
        sut = CharacterLocalDataManager()
        
        deleteExistingCharactersLocal()// CharactersRepository creates objects before Resolver registers Mock Services which stops its actions. Created objects are deleted here
    }
    
    override func tearDown() {
        sut = nil
        Resolver.root = .main
        super.tearDown()
    }
    
    // MARK: - Unit Tests
    
    func test_CharacterLocalDataManager_fetchCharacters_ShouldFetchAndSort() {
        // Given
        for n in 1...10 {
            sut?.updateOrCreateLocalCharacterUsing(characterNetwork: mockCharacterNetwork(inputId: n, randomString: UUID().uuidString), charactersLocal: characters)
            fetchCharacters()
        }

        // When
        fetchCharacters()

        // Then
        XCTAssertEqual(characters.count, 10)
        let sortedByID = characters.sorted(by: { $0.id < $1.id }) // Check if sorted by ID
        XCTAssertEqual(characters, sortedByID)
    }
    
    func test_CharacterLocalDataManager_updateOrCreateLocalCharacterUsing_UsersAreUniqueById() {
        // Given
        let createAmountOfCharacters: Int = 10
        
        let randomStringFirstRound = UUID().uuidString
        let randomStringSecondRound = UUID().uuidString
            
        guard let sut = sut else { return }
        
        // When
        for n in 1...createAmountOfCharacters {
            sut.updateOrCreateLocalCharacterUsing(characterNetwork: mockCharacterNetwork(inputId: n, randomString: randomStringFirstRound), charactersLocal: characters)
            fetchCharacters()
        }
        
        for n in 1...createAmountOfCharacters {
            sut.updateOrCreateLocalCharacterUsing(characterNetwork: mockCharacterNetwork(inputId: n, randomString: randomStringSecondRound), charactersLocal: characters)
            fetchCharacters()
        }
        
        for _ in 1...createAmountOfCharacters {
            sut.updateOrCreateLocalCharacterUsing(characterNetwork: mockCharacterNetwork(inputId: 1, randomString: randomStringSecondRound), charactersLocal: characters)
            fetchCharacters()
        }
        
        // Then
        var returnRandomCharacter: CharacterLocal {
            return characters[Int.random(in: 0...createAmountOfCharacters-1)]
        }
        
        XCTAssertEqual(characters.count, createAmountOfCharacters) //Checks if characters update and not create over and over
        XCTAssertEqual(returnRandomCharacter.name, randomStringSecondRound) // Checks if characters update their values
        XCTAssertEqual(returnRandomCharacter.status, randomStringSecondRound)
        XCTAssertEqual(returnRandomCharacter.species, randomStringSecondRound)
        XCTAssertEqual(returnRandomCharacter.type, randomStringSecondRound)
        XCTAssertEqual(returnRandomCharacter.gender, randomStringSecondRound)
        XCTAssertEqual(returnRandomCharacter.originName, randomStringSecondRound)
        XCTAssertEqual(returnRandomCharacter.locationName, randomStringSecondRound)
        XCTAssertEqual(returnRandomCharacter.imageUrl, randomStringSecondRound)
        XCTAssertEqual(returnRandomCharacter.url, randomStringSecondRound)
    }
}


// MARK: - Helper Private Methods

extension CharacterLocalDataManager_Tests {
    
    private func deleteExistingCharactersLocal() {
        fetchCharacters()
        for character in characters { // CharactersRepository creates objects before Resolver registers Mock Services which stops its actions. Created objects are deleted here
            dataController.moc.delete(character)
            try? dataController.moc.save()
        }
    }
    
    private func fetchCharacters() {
        guard let sut = sut else { fatalError() }
        
        sut.fetchCharacters { result in
            switch result {
            case .success(let loaded):
                self.characters = loaded
            case .failure(let error):
                print("error loading: \(error)")
            }
        }
        
    }
    
    private func mockCharacterNetwork(inputId: Int, randomString: String) -> CharacterNetwork {
        return CharacterNetwork(id: Int16(inputId),
                                name: randomString,
                                status: randomString,
                                species: randomString,
                                type: randomString,
                                gender: randomString,
                                origin: OriginOrLocation(name: randomString, url: randomString),
                                location: OriginOrLocation(name: randomString, url: randomString),
                                image: randomString,
                                url: randomString,
                                created: randomString)
    }
    
}
