//
//  LocalDataManagerProtocol.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation

protocol CharacterLocalManagerProtocol {
    func fetchCharacters() throws -> [CharacterLocal]
    func updateOrCreateLocalCharacterUsing(characterNetwork: CharacterNetwork, charactersLocal: [CharacterLocal])
    func saveContext()
}
