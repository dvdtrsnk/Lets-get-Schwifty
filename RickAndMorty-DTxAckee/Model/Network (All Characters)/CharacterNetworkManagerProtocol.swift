//
//  NetworkManagerProtocol.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation

protocol CharacterNetworkManagerProtocol {
    func fetchCharactersPage(_ number: Int, completion: @escaping (Result<CharacterFetchModel, NetworkFetchErrors>) -> ())
}
