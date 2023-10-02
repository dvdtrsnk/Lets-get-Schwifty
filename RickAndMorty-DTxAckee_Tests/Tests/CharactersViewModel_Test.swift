//
//  CharactersViewModel_Test.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Třešňák on 02.10.2023.
//

import XCTest
import Resolver
@testable import RickAndMorty_DTxAckee

final class CharactersViewModel_Test: XCTestCase {

    @LazyInjected var charactersRepository: MockCharactersRepository
    @LazyInjected var dataController: MockDataController
    var sut: CharactersViewModel?
    
    // MARK: - Life Cycle
    
    override func setUp() {
        super.setUp()
        
        Resolver.registerMockServices()
        sut = CharactersViewModel()
    }
    
    override func tearDown() {
        sut = nil
        Resolver.root = .main
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_CharactersViewModel_ShouldRecieveCharactersFromCharactersRepository() {
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
    
    func test_CharactersViewModel_ShouldFilterCharacters() {
        let expectation = XCTestExpectation(description: "Filter Characters")
        guard let sut = sut else { fatalError("sut nil") }
        
        // Given
        let ricksAmount = Int.random(in: 10...30)
        let mortysAmount = Int.random(in: 10...30)
        
        charactersRepository.characters = mockCharacterLocalArray(ricksAmount, mortysAmount)
        
        // When
        
        sut.searchField = "M"
        
        // Then
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            
            XCTAssertEqual(sut.charactersFiltered.count, mortysAmount)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    

}


// MARK: - Helper Private Methods

extension CharactersViewModel_Test {
    
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
