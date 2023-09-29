//
//  LocalDataManagerProtocol.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Třešňák on 29.09.2023.
//

import Foundation

protocol LocalDataManagerProtocol {
    func fetchCharacters(completion: @escaping (Result<[CharacterLocal], LocalDataErrors>) -> Void)
    func updateOrCreateLocalCharacterUsing(characterNetwork: CharacterNetwork, charactersLocal: [CharacterLocal])
    func saveContext()
}
