//
//  NetworkManagerProtocol.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation

protocol CharacterNetworkManagerProtocol {
    func fetchCharactersPage(_ number: Int) async throws -> CharacterFetchModel
}
