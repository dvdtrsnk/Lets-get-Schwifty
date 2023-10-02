//
//  MockCharacterNetworkManager.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Tresnak
//

import Foundation
@testable import RickAndMorty_DTxAckee

class MockCharacterNetworkManager: CharacterNetworkManagerProtocol {
    
    // MARK: - Properties

    var result: Result<RickAndMorty_DTxAckee.CharacterFetchModel, RickAndMorty_DTxAckee.NetworkFetchErrors>?
    
    // MARK: - Public Method
    
    func fetchCharactersPage(_ number: Int, completion: @escaping (Result<RickAndMorty_DTxAckee.CharacterFetchModel, RickAndMorty_DTxAckee.NetworkFetchErrors>) -> ()) {
        
        guard let result = result else { fatalError("Result is nil") }
        
        return completion(result)
    }
}
