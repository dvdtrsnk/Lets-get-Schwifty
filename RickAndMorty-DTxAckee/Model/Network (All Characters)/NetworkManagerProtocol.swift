//
//  NetworkManagerProtocol.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchCharactersPage(_ number: Int, completion: @escaping (Result<CharacterFetchModel, NetworkFetchErrors>) -> ())
}
