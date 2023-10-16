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
    func fetchCharactersPage(_ number: Int) async throws -> RickAndMorty_DTxAckee.CharacterFetchModel {
        guard let result = result else { fatalError("Result is nil") }
        switch result {
        case .success(let characters):
            return characters
        case .failure(let error):
            throw error
        }
    }
}
