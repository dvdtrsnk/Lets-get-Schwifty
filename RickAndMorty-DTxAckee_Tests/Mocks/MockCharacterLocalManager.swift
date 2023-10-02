//
//  MockCharacterLocalManager.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Tresnak
//

import Foundation
@testable import RickAndMorty_DTxAckee

class MockCharacterLocalManager: CharacterLocalManagerProtocol {
    
    //MARK: - Properties
    
    var result: Result<[RickAndMorty_DTxAckee.CharacterLocal], RickAndMorty_DTxAckee.LocalDataErrors>?
    
    //MARK: - Public Methods
    
    func fetchCharacters() throws -> [RickAndMorty_DTxAckee.CharacterLocal] {
        guard let result = result else { fatalError("Result is nil") }
        
        switch result {
        case .success(let characters):
            return characters
        case .failure(let error):
            throw error
        }
    }
    
    func updateOrCreateLocalCharacterUsing(characterNetwork: RickAndMorty_DTxAckee.CharacterNetwork, charactersLocal: [RickAndMorty_DTxAckee.CharacterLocal]) {
        
    }
    
    func saveContext() {
        
    }
    
    
}
