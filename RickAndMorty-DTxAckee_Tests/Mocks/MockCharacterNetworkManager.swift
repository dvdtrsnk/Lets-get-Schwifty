//
//  MockCharacterNetworkManager.swift
//  RickAndMorty-DTxAckee_Tests
//
//  Created by David Tresnak
//

import Foundation
@testable import RickAndMorty_DTxAckee

class MockCharacterNetwork: CharacterNetworkManagerProtocol {
    
    var result: Result<Data, RickAndMorty_DTxAckee.NetworkFetchErrors>?
    
    func fetchCharactersPage(_ number: Int, completion: @escaping (Result<RickAndMorty_DTxAckee.CharacterFetchModel, RickAndMorty_DTxAckee.NetworkFetchErrors>) -> ()) {
        
    }
    
    
}
