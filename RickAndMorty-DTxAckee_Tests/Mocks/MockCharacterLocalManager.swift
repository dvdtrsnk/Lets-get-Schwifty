//
//  MockCharacterLocalManager.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Tresnak
//

import Foundation
@testable import RickAndMorty_DTxAckee

class MockCharacterLocalManager: CharacterLocalManagerProtocol {
    
    var result: Result<[RickAndMorty_DTxAckee.CharacterLocal], RickAndMorty_DTxAckee.LocalDataErrors>?
    
    func fetchCharacters(completion: @escaping (Result<[RickAndMorty_DTxAckee.CharacterLocal], RickAndMorty_DTxAckee.LocalDataErrors>) -> Void) {
        guard let result = result else { fatalError("Result is nil") }
        
        return completion(result)
    }
    
    func updateOrCreateLocalCharacterUsing(characterNetwork: RickAndMorty_DTxAckee.CharacterNetwork, charactersLocal: [RickAndMorty_DTxAckee.CharacterLocal]) {
        
    }
    
    func saveContext() {
        
    }
    
    
}
