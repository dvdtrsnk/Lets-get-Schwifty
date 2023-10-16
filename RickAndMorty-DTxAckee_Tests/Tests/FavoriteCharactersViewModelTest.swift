//
//  FavoriteCharactersViewModel_Test.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Třešňák on 02.10.2023.
//

import XCTest
import Resolver
@testable import RickAndMorty_DTxAckee

final class FavoriteCharactersViewModelTest: XCTestCase {

    @LazyInjected var charactersRepository: MockCharactersRepository
    @LazyInjected var dataController: MockDataController
    
    var sut: FavoriteCharactersViewModel?
    
    // MARK: - Life Cycle
    
    override func setUp() {
        super.setUp()
        
        Resolver.registerMockServices()
        sut = FavoriteCharactersViewModel()
    }
    
    override func tearDown() {
        sut = nil
        Resolver.root = .main
        super.tearDown()
    }
    
    // MARK: - Unit Tests
    
    func test_FavoriteCharactersViewModel_ShouldRecieveCharactersFromCharactersRepository() {
        let expectation = XCTestExpectation(description: "Recieve form CharactersRepository")
        guard let sut = sut else { fatalError("sut nil") }
        
        // Given
        let ricksAmount = Int.random(in: 10...30)
        let mortysAmount = Int.random(in: 10...30)

        
        // When
        charactersRepository.characters = mockCharacterLocalArray(ricksAmount, mortysAmount)

        
        // Then
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            
            XCTAssertEqual(sut.characters.count, ricksAmount+mortysAmount)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    
    func test_FavoriteCharactersViewModel_ShouldFilterFavoriteCharacters() {
        let expectation = XCTestExpectation(description: "Filter Favorite Characters")
        guard let sut = sut else { fatalError("sut nil") }
        
        // Given
        let favoriteCharacters = Int.random(in: 5...20)
        let ricksAmount = Int.random(in: 10...30)
        let mortysAmount = Int.random(in: 10...30)

        // When
        charactersRepository.characters = mockCharacterLocalArray(ricksAmount, mortysAmount)
        markCharactersFavorite(amount: favoriteCharacters)

        
        // Then
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            
            XCTAssertEqual(sut.favoriteCharacters.count, favoriteCharacters)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    
}

// MARK: - Helper Private Methods

extension FavoriteCharactersViewModelTest {
    
    private func markCharactersFavorite(amount: Int) {
        let charactersCount = charactersRepository.characters.count
        let numberOfFavoritesToSet = min(amount, charactersCount)
        
        for index in 0..<numberOfFavoritesToSet {
            charactersRepository.characters[index].isFavorite = true
        }
    }

    
    private func mockCharacterLocalArray(_ ricksAmount: Int,_  mortysAmount: Int) -> [CharacterLocal] {
        var arrayOfCharacters: [CharacterLocal] = []
        
        for _ in 1...ricksAmount {
            arrayOfCharacters.append(mockCharacterLocal(name: "Rick"))
        }
        
        for _ in 1...mortysAmount {
            arrayOfCharacters.append(mockCharacterLocal(name: "Morty"))
        }
        
        return arrayOfCharacters
        
    }
    
    private func mockCharacterLocal(name: String) -> CharacterLocal {
        let character = CharacterLocal(context: dataController.moc)
        character.id = Int16.random(in: 1...9999)
        character.name = name
        
        return character
    }
    
}
