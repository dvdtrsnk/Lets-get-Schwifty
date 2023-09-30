//
//  LocalDataManagerProtocol.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation

protocol CharacterLocalManagerProtocol {
    func fetchCharacters(completion: @escaping (Result<[CharacterLocal], LocalDataErrors>) -> Void)
    func updateOrCreateLocalCharacterUsing(characterNetwork: CharacterNetwork, charactersLocal: [CharacterLocal])
    func saveContext()
}
