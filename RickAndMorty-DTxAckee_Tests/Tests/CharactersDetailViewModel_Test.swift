//
//  CharactersDetailViewModel_Test.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Třešňák on 02.10.2023.
//

import XCTest
import Resolver
@testable import RickAndMorty_DTxAckee

final class CharactersDetailViewModel_Test: XCTestCase {

    @LazyInjected var charactersRepository: MockCharactersRepository
    @LazyInjected var dataController: MockDataController
    
    var sut: CharactersDetailViewModel?
    
    // MARK: - Life Cycle
    
    override func setUp() {
        super.setUp()
        
        Resolver.registerMockServices()
        sut = CharactersDetailViewModel(returnMockCharacterLocal())
    }
    
    override func tearDown() {
        sut = nil
        Resolver.root = .main
        super.tearDown()
    }
    
    // MARK: - Unit Tests 

    func test_CharactersDetailViewModel_SwitchIsFavorite() async {
        guard let sut = sut else { fatalError("sut is nil") }
        let expectation = XCTestExpectation(description: "Switch is Favorite")
        
        // Given
        
        // When
        await sut.switchIsFavorite()
        
        // Then
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(sut.character.isFavorite)
            XCTAssertTrue(sut.isFavorite)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
}


// MARK: - Helper Private Methods

extension CharactersDetailViewModel_Test {
    
    private func returnMockCharacterLocal() -> CharacterLocal {
        let character = CharacterLocal(context: dataController.moc)
        character.name = "Rick"
        character.isFavorite = false
        
        return character
    }
}
